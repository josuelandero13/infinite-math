import { Controller } from "@hotwired/stimulus";
import { Chart, registerables } from "chart.js";

Chart.register(...registerables);

export default class extends Controller {
  static targets = ["expression", "result"];

  async calculateDerivative(event) {
    event.preventDefault();

    const expression = event.target.querySelector("#expression").value;

    const response = await fetch("/calculate_derivative", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
          .content,
      },
      body: JSON.stringify({ expression: expression }),
    });

    const data = await response.json();

    if (response.ok) {
      document.getElementById(
        "result"
      ).innerText = `Derivada: ${data.derivative}`;
      this.plotGraph(expression, data.derivative);
    } else {
      document.getElementById("result").innerText = `Error: ${data.error}`;
    }
  }

  plotGraph(expression, derivative) {
    const divCanvas = document.getElementById("derivative-chart").getContext("2d");

    const xValues = [];
    const yValues = [];
    for (let x = -10; x <= 10; x += 0.1) {
      xValues.push(x);
      yValues.push(math.evaluate(derivative, { x: x }));
    }

    const chart = new Chart(divCanvas, {
      type: "line",
      data: {
        labels: xValues,
        datasets: [
          {
            label: `Derivada de ${expression}`,
            data: yValues,
            borderColor: "blue",
            borderWidth: 1,
            fill: false,
          },
        ],
      },
      options: {
        responsive: true,
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
  }
}
