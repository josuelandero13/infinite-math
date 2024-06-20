import { Controller } from "@hotwired/stimulus";
import { Chart, registerables } from "chart.js";

Chart.register(...registerables);

export default class extends Controller {
  static targets = ["equations", "equation"];

  addEquation() {
    const newEquation = this.equationTarget.cloneNode(true);

    newEquation
      .querySelectorAll("input")
      .forEach((input) => (input.value = ""));
    this.equationsTarget.appendChild(newEquation);
  }

  solve(event) {
    event.preventDefault();
    this.clearResults();
    const equations = this.equationsTarget.querySelectorAll(".equation");
    const resultsDiv = document.getElementById("results");

    if (equations.length < 2) {
      resultsDiv.textContent =
        "Se necesitan al menos dos ecuaciones para resolver el sistema.";
      return;
    }

    try {
      const { matrixA, matrixB } = this.extractMatrices(equations);
      const solution = this.solveLinearSystem(matrixA, matrixB);
      this.displayDeterminants(matrixA, matrixB, solution);
      this.displaySolution(solution);
      this.plotGraph(matrixA, matrixB, solution);
    } catch (error) {
      resultsDiv.textContent = `Error en la entrada: ${error.message}`;
    }
  }

  clearResults() {
    const resultsDiv = document.getElementById("results");
    const resultsChart = document.getElementById("resultsChart");

    resultsDiv.innerHTML = "";
    if (resultsChart && resultsChart.chart) {
      resultsChart.chart.destroy();
    }
  }

  extractMatrices(equations) {
    const matrixA = [];
    const matrixB = [];

    equations.forEach((equation) => {
      const a = this.parseInput(
        equation.querySelector("input[name='a[]']").value
      );
      const b = this.parseInput(
        equation.querySelector("input[name='b[]']").value
      );
      const c = this.parseInput(
        equation.querySelector("input[name='c[]']").value
      );
      matrixA.push([a, b]);
      matrixB.push(c);
    });

    return { matrixA, matrixB };
  }

  parseInput(value) {
    const parsed = parseFloat(value);
    if (isNaN(parsed)) {
      throw new Error("Las entradas deben ser números válidos.");
    }
    return parsed;
  }

  solveLinearSystem(A, B) {
    // Se utiliza la regla de Cramer para resolver el sistema
    const detA = A[0][0] * A[1][1] - A[0][1] * A[1][0];

    if (detA === 0) {
      throw new Error("El sistema de ecuaciones no tiene solución única.");
    }

    const detX = B[0] * A[1][1] - A[0][1] * B[1];
    const detY = A[0][0] * B[1] - B[0] * A[1][0];

    return {
      solution: [detX / detA, detY / detA],
      detA,
      detX,
      detY,
    };
  }

  displaySolution({ solution }) {
    const VALUE_X = 0,
      VALUE_Y = 1;
    const resultsDiv = document.getElementById("results");
    const x = solution[VALUE_X].toFixed(4);
    const y = solution[VALUE_Y].toFixed(4);

    resultsDiv.innerHTML += `<p>La solución es x = ${x}, y = ${y}</p>`;
  }

  displayDeterminants(matrixA, matrixB, determinants) {
    const { detA, detX, detY } = determinants;
    const resultsDiv = document.getElementById("results");

    const ROW_0 = 0,
      ROW_1 = 1,
      COL_0 = 0,
      COL_1 = 1;

    const determinantsHtml = `
      <p>Determinante de A (detA): ${detA}</p>
      <p>Determinante para x (detX): ${detX}</p>
      <p>Determinante para y (detY): ${detY}</p>
    `;

    const formulasHtml = `
      <p>Fórmulas:</p>
      <p>
        detA = ${matrixA[ROW_0][COL_0]} *
               ${matrixA[ROW_1][COL_1]} -
               ${matrixA[ROW_0][COL_1]} *
               ${matrixA[ROW_1][COL_0]}
      </p>
      <p>
        detX = ${matrixB[ROW_0]} *
               ${matrixA[ROW_1][COL_1]} -
               ${matrixA[ROW_0][COL_1]} *
               ${matrixB[ROW_1]}
      </p>
      <p>
        detY = ${matrixA[ROW_0][COL_0]} *
               ${matrixB[ROW_1]} -
               ${matrixB[ROW_0]} *
               ${matrixA[ROW_1][COL_0]}
      </p>
    `;

    resultsDiv.innerHTML += determinantsHtml + formulasHtml;
  }

  plotGraph(matrixA, matrixB, { solution }) {
    const divCanvas = document.getElementById("resultsChart").getContext("2d");

    const datasets = matrixA.map((row, index) => {
      const VALUE_ONE = 0,
        VALUE_TWO = 1;
      const slope = -row[VALUE_ONE] / row[VALUE_TWO];
      const intercept = matrixB[index] / row[VALUE_TWO];

      return {
        label: `Ecuación ${index + 1}`,
        data: this.generateLineData(slope, intercept),
        borderColor: `hsl(${index * 60}, 100%, 50%)`,
        fill: false,
        tension: 0.1,
      };
    });

    const solutionDataset = {
      label: "Solución",
      data: [{ x: solution[0], y: solution[1] }],
      borderColor: "black",
      backgroundColor: "black",
      pointRadius: 5,
      type: "scatter",
    };

    const chart = new Chart(divCanvas, {
      type: "line",
      data: {
        datasets: [...datasets, solutionDataset],
      },
      options: {
        scales: {
          x: {
            type: "linear",
            position: "bottom",
          },
          y: {
            type: "linear",
          },
        },
      },
    });

    document.getElementById("resultsChart").chart = chart;
  }

  generateLineData(slope, intercept) {
    const data = [];

    for (let x = -10; x <= 10; x += 0.1) {
      const y = slope * x + intercept;
      data.push({ x, y });
    }
  
    return data;
  }
}
