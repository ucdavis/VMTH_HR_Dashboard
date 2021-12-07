// set the dimensions and margins of the graph
const margin = {top: 90, right: 40, bottom: 200, left: 40},
    width = 1040 - margin.left - margin.right,
    height = 810 - margin.top - margin.bottom;

// append the svg object to the body of the page
const svg = d3.select("#table1")
  .append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", `translate(${margin.left},${margin.top})`);

// Parse the Data
d3.csv("all_stuff3.csv").then( function(data) {

// X axis
const x = d3.scaleBand()
  .range([ 0, width ])
  .domain(data.map(d => d.date))
  .padding(0.2);
svg.append("g")
  .attr("transform", `translate(0, ${height})`)
  .call(d3.axisBottom(x))
  .selectAll("text")
    .attr("transform", "translate(-10,0)rotate(-45)")
    .style("text-anchor", "end");

// Add Y axis
const y = d3.scaleLinear()
  .domain([0, 20])
  .range([ height, 0]);
svg.append("g")
  .call(d3.axisLeft(y));

// Bars
svg.selectAll("mybar")
  .data(data)
  .join("rect")
    .attr("x", d => x(d.date))
    .attr("y", d => y(d.value))
    .attr("width", x.bandwidth())
    .attr("height", d => height - y(d.value))
    .attr("fill", "#855CF8")
    .attr("class", "bar")


    svg.append("text")
    .attr("class", "title-bar")
        .attr("x", 0)
        .attr("y", -60)
        .attr("text-anchor", "left")
        .text("Monthly Absent Rate");

// Add subtitle to graph
svg.append("text")
.attr("class", "subtitle-bar")
        .attr("x", 0)
        .attr("y", -40)
        .attr("text-anchor", "left")
        .text("Across All Departments");

})