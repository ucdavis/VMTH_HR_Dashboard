// set the dimensions and margins of the graph
const margin = {top: 10, right: 30, bottom: 70, left: 60},
    width = 1460 - margin.left - margin.right,
    height = 700 - margin.top - margin.bottom;

// append the svg object to the body of the page
const svg = d3.select("#my_dataviz")
  .append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", `translate(${margin.left}, ${margin.top})`);

//Read the data
d3.csv("dat23.csv").then( function(data) {

    // List of groups (here I have one group per column)
    const allGroup = new Set(data.map(d => d.name))

    const groups = data.map(d => d.year)
    // add the options to the button
    d3.select("#selectButton")
      .selectAll('myOptions')
     	.data(allGroup)
      .enter()
    	.append('option')
      .text(function (d) { return d; }) // text showed in the menu
      .attr("value", function (d) { return d; }) // corresponding value returned by the button

    // A color scale: one color for each group
    const myColor = d3.scaleOrdinal()
      .domain(allGroup)
      .range(d3.schemeSet2);

    // Add X axis --> it is a date format
    const x = d3.scaleBand()
  .range([ 0, width ])
  .domain(data.map(d => d.year))
  .padding(0.2);
svg.append("g")
  .attr("transform", `translate(0, ${height})`)
  .call(d3.axisBottom(x))
  .selectAll("text")
    .attr("transform", "translate(-10,0)rotate(-45)")
    .style("text-anchor", "end");

// Add Y axis
const y = d3.scaleLinear()
  .domain([0, 1.2])
  .range([ height, 0]);
svg.append("g")
  .call(d3.axisLeft(y)
  .tickFormat(d3.format(".0%")));
  
  

  

// Bars
var line = svg.selectAll("mybar")
.data(data.filter(function(d){return d.name=="VMTH"}))
  .join("rect")
    .attr("x", d => x(d.year))
    .attr("y", d => y(d.n))
    .attr("width", x.bandwidth())
    .attr("height", d => height - y(d.n))
    .attr("fill", "#855CF8")
    .attr("class","bar22")

    var text = svg.selectAll(".barText")
    .data(data.filter(function(d){return d.name=="VMTH"}))                             
      .enter().append("text")
      .attr("class", "barText")
      .attr("x", function(d) { return x(d.year )+10; })
      .attr("y", function(d) { return y(d.n)-5; })
      .text(function(d) { return d.n2; })
      ;
    

    function update(selectedGroup) {

        // Create new data with the selection?
        const dataFilter = data.filter(function(d){return d.name==selectedGroup})
  
        // Give these new data to update line
        line
        .data(dataFilter)
        .transition()
          .duration(1000)
            .attr("x", d => x(d.year))
            .attr("y", d => y(d.n))
            .attr("width", x.bandwidth())
            .attr("height", d => height - y(d.n))
            .attr("fill", function(d){ return myColor(selectedGroup) })
            .attr("class","bar222")


            
            text
            .data(dataFilter)
            .transition()
                .duration(1000)
                .attr("x", function(d) { return x(d.year )+10; })
                .attr("y", function(d) { return y(d.n); })
                .text(function(d) { return d.n2; })

    }
  
      // When the button is changed, run the updateChart function
      d3.select("#selectButton").on("change", function(event,d) {
          // recover the option that has been chosen
          const selectedOption = d3.select(this).property("value")
          // run the updateChart function with this selected option
          update(selectedOption)
      })

    

})