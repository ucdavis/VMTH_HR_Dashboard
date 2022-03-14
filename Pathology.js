async function drawBarChart2() {

  // 1. Access data
  var margin = {top: 70, right: 10, bottom: 10, left: 10},
  width = 300 - margin.left - margin.right,
  height = 165 ;

// set the ranges
var y = d3.scaleBand()
        .range([0, height])
        .padding(0.3);
var x = d3.scaleLinear()
        .range([0,width]);
        
// append the svg object to the body of the page
// append a 'group' element to 'svg'
// moves the 'group' element to the top left margin
var svg = d3.select("#my_dataviz").append("svg")
  .attr("width", width + margin.left + margin.right)
  .attr("height", height + margin.top + margin.bottom)
  .attr("class", "graph-svg-component")
.append("g")
  .attr("transform", 
        "translate(" + margin.left + "," + margin.top + ")");

// get the data
d3.csv("ab_per_day_PATHOLOGY.csv").then(function(data) {

// format the data
data.forEach(function(d) {
  d.Absences = +d.Absences;
});

var max_v = d3.max(data, function(d) { return d.Absences; })
// Scale the range of the data in the domains
y.domain(data.map(function(d) { return d.Day; }));
x.domain([0, max_v + max_v*.15]);

// append the rectangles for the bar chart
svg.selectAll(".bar")
    .data(data)
  .enter().append("rect")
    .attr("class", "bar")
    .attr("fill", "#69b3a2")
    .attr("y", function(d) { return y(d.Day); })
    .attr("height", y.bandwidth())
    .attr("x", x(0) )
    .attr("width", function(d) { return  x(d.Absences); });

   svg.selectAll("text.bar")
    .data(data)
  .enter().append("text")
    .attr("class", "text-bar2")
    .attr("text-anchor", "middle")
    .attr("x", function(d) { return x(d.Absences + .05*max_v); })
    .attr("y", function(d) { return y(d.Day) + y.bandwidth()/2 +3 ; })
    .text(function(d) { return d.Absences; });

  
    svg.selectAll("text.bar")
    .data(data)
  .enter().append("text")
    .attr("class", "text-bar")
    .attr("text-anchor", "left")
    .attr("fill", "black")
    .attr("x", 5)
    .attr("y", function(d) { return y(d.Day) + y.bandwidth()/2 +10; })
    .text(function(d) { return d.Day; });

    svg.append("text")
    .attr("class", "title-bar")
        .attr("x", 0)
        .attr("y", -45)
        .attr("text-anchor", "left")
        .text("Average Absences By Day");

// Add subtitle to graph
svg.append("text")
.attr("class", "subtitle-bar")
        .attr("x", 0)
        .attr("y", -20)
        .attr("text-anchor", "left")
        .text("February 2022");

  


   
svg.selectAll(".bartext")
.data(data)
.enter()
.append("text")
.attr("class", "bartext")
.attr("text-anchor", "middle")
.attr("fill", "white")
.attr("x", function(d,i) {
    return x(i)+x.rangeBand()/2;
})
.attr("y", function(d,i) {
    return height-y(d)+yTextPadding;
})
.text(function(d){
     return d;


});

// add the x Axis
svg.append("g")
    .attr("transform", "translate(0," + height + ")")
    .call(d3.axisBottom(x));

// add the y Axis
svg.append("g")
    .call(d3.axisLeft(y));

});
}
drawBarChart2()


async function drawBarChart3() {

  // 1. Access data
 

// get the data
d3.csv("ab_by_week_PATHOLOGY.csv").then(function(data) {

    var margin = {top: 70, right: 0, bottom: 10, left: 10},
    width = 300 - margin.left - margin.right,
    height = 165 ;
  
    var max_v = d3.max(data, function(d) { return d.Absences; })
  // set the ranges
  var y = d3.scaleBand()
          .range([0, height])
          .padding(0.3);
  var x = d3.scaleLinear()
          .range([0,width]);
          
  // append the svg object to the body of the page
  // append a 'group' element to 'svg'
  // moves the 'group' element to the top left margin
  var svg = d3.select("#my_dataviz2").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", 
          "translate(" + margin.left + "," + margin.top + ")");

// format the data
data.forEach(function(d) {
  d.Absences = +d.Absences;
});

var max_v = d3.max(data, function(d) { return d.Absences; })

// Scale the range of the data in the domains
y.domain(data.map(function(d) { return d.Day; }));
x.domain([0,max_v+.15*max_v ]);


var max_v = d3.max(data, function(d) { return d.Absences; })
// append the rectangles for the bar chart
svg.selectAll(".bar")
    .data(data)
  .enter().append("rect")
    .attr("class", "bar")
    .attr("fill", "#69b3a2")
    .attr("y", function(d) { return y(d.Day); })
    .attr("height", y.bandwidth())
    .attr("x", x(0) )
    .attr("width", function(d) { return  x(d.Absences); });

   svg.selectAll("text.bar")
    .data(data)
  .enter().append("text")
    .attr("class", "text-bar2")
    .attr("text-anchor", "middle")
    .attr("x", function(d) { return x(d.Absences + .05*max_v); })
    .attr("y", function(d) { return y(d.Day) + y.bandwidth()/2 +3 ; })
    .text(function(d) { return d.Absences; });

  
    svg.selectAll("text.bar")
    .data(data)
  .enter().append("text")
    .attr("class", "text-bar")
    .attr("text-anchor", "left")
    .attr("fill", "black")
    .attr("x", 5)
    .attr("y", function(d) { return y(d.Day) + y.bandwidth()/2 +10; })
    .text(function(d) { return d.Day; });

    svg.append("text")
    .attr("class", "title-bar")
        .attr("x", 0)
        .attr("y", -45)
        .attr("text-anchor", "left")
        .text("Average Absences By Week");

// Add subtitle to graph
svg.append("text")
.attr("class", "subtitle-bar")
        .attr("x", 0)
        .attr("y", -20)
        .attr("text-anchor", "left")
        .text("February 2022");

  


   
svg.selectAll(".bartext")
.data(data)
.enter()
.append("text")
.attr("class", "bartext")
.attr("text-anchor", "middle")
.attr("fill", "white")
.attr("x", function(d,i) {
    return x(i)+x.rangeBand()/2;
})
.attr("y", function(d,i) {
    return height-y(d)+yTextPadding;
})
.text(function(d){
     return d;


});

// add the x Axis
svg.append("g")
    .attr("transform", "translate(0," + height + ")")
    .call(d3.axisBottom(x));

// add the y Axis
svg.append("g")
    .call(d3.axisLeft(y));

});
}
drawBarChart3()



async function drawBarChart4() {

  // 1. Access data
  var margin = {top: 70, right: 10, bottom: 10, left: 10},
  width = 300 - margin.left - margin.right,
  height = 165 ;

// set the ranges
var y = d3.scaleBand()
        .range([0, height])
        .padding(0.3);
var x = d3.scaleLinear()
        .range([0,width]);
        
// append the svg object to the body of the page
// append a 'group' element to 'svg'
// moves the 'group' element to the top left margin
var svg = d3.select("#my_dataviz3").append("svg")
  .attr("width", width + margin.left + margin.right)
  .attr("height", height + margin.top + margin.bottom)
.append("g")
  .attr("transform", 
        "translate(" + margin.left + "," + margin.top + ")");

// get the data
d3.csv("ab_by_type_PATHOLOGY.csv").then(function(data) {

// format the data
data.forEach(function(d) {
  d.Absences = +d.Absences;
});

// Scale the range of the data in the domains
y.domain(data.map(function(d) { return d.Day; }));
x.domain([0, 100]);

// append the rectangles for the bar chart
svg.selectAll(".bar")
    .data(data)
  .enter().append("rect")
    .attr("class", "bar")
    .attr("fill", "#69b3a2")
    .attr("y", function(d) { return y(d.Day); })
    .attr("height", y.bandwidth())
    .attr("x", x(0) )
    .attr("width", function(d) { return  x(d.Absences); });

    svg.selectAll("text.bar")
    .data(data)
  .enter().append("text")
    .attr("class", "text-bar2")
    .attr("text-anchor", "middle")
    .attr("x", function(d) { return x(d.Absences + 7); })
    .attr("y", function(d) { return y(d.Day) + y.bandwidth()/2 +3 ; })
    .text(function(d) { return d.Absences + "%"; });

    var formatText = d3.format('.0%');

    svg.selectAll("text.bar")
    .data(data)
  .enter().append("text")
    .attr("class", "text-bar")
    .attr("text-anchor", "left")
    .attr("fill", "black")
    .attr("x", 5)
    .attr("y", function(d) { return y(d.Day) + y.bandwidth()/2 +10; })
    .text(function(d) { return d.Day; });

    svg.append("text")
    .attr("class", "title-bar")
        .attr("x", 0)
        .attr("y", -45)
        .attr("text-anchor", "left")
        .text("Percent of Absences by Type");

// Add subtitle to graph
svg.append("text")
.attr("class", "subtitle-bar")
        .attr("x", 0)
        .attr("y", -20)
        .attr("text-anchor", "left")
        .text("February 2022");

  


   
svg.selectAll(".bartext")
.data(data)
.enter()
.append("text")
.attr("class", "bartext")
.attr("text-anchor", "middle")
.attr("fill", "white")
.attr("x", function(d,i) {
    return x(i)+x.rangeBand()/2;
})
.attr("y", function(d,i) {
    return height-y(d)+yTextPadding;
})
.text(function(d){
     return d;


});

// add the x Axis
svg.append("g")
    .attr("transform", "translate(0," + height + ")")
    .call(d3.axisBottom(x));

// add the y Axis
svg.append("g")
    .call(d3.axisLeft(y));

});
}
drawBarChart4()





async function drawheat() {

var margin = {top: 65, right: 5, bottom: 25, left: 75},
  width = 440 - margin.left - margin.right,
  height = 290 - margin.top - margin.bottom;

// append the svg object to the body of the page
var svg = d3.select("#heat")
.append("svg")
  .attr("width", width + margin.left + margin.right)
  .attr("height", height + margin.top + margin.bottom)
.append("g")
  .attr("transform",
        "translate(" + margin.left + "," + margin.top + ")");

//Read the data
d3.csv("heat_csv_PATHOLOGY.csv").then(function(data){

  // Labels of row and columns -> unique identifier of the column called 'group' and 'variable'
  var myGroups = d3.map(data, function(d){return d.Day;})
  var myVars = d3.map(data, function(d){return d.Type;})

  

  // Build X scales and axis:
  var x = d3.scaleBand()
    .range([ 0, width ])
    .domain(myGroups)
    .padding(0.05);
  svg.append("g")
    .attr("class", "text-heat")
    .attr("transform", "translate(0," +   height + ")")
    .call(d3.axisBottom(x).tickSize(0))
    .select(".domain").remove()
    

  // Build Y scales and axis:
  var y = d3.scaleBand()
    .range([ height, 0 ])
    .domain(myVars)
    .padding(0.05);
  svg.append("g")
    .attr("class", "text-heat")
    .call(d3.axisLeft(y).tickSize(0))
    .select(".domain").remove()
    

  // Build color scale
  var myColor = d3.scaleSequential()
    .interpolator(d3.interpolateInferno)
    .domain([0,d3.max(data, function(d) { return d.Value; })])

  // create a tooltip
  var tooltip = d3.select("#heat")
    .append("div")
    .style("opacity", 0)
    .attr("class", "tooltip")
    .style("background-color", "white")
    .style("border", "solid")
    .style("border-width", "2px")
    .style("border-radius", "5px")
    .style("padding", "5px")
    .style("height","40px")
    .style("width","80px")

  // Three function that change the tooltip when user hover / move / leave a cell
  var mouseover = function(d) {
    tooltip
      .style("opacity", 1)
    d3.select(this)
      .style("stroke", "black")
      .style("opacity", 1)
  }
  var mousemove = function(d) {
    tooltip
      .html("The exact value of<br>this cell is: " +    d.Value )
      .style("left", (d3.pointer(this)[0]+70) + "px")
      .style("top", (d3.pointer(this)[1]) + "px")
  }
  var mouseleave = function(d) {
    tooltip
      .style("opacity", 0)
    d3.select(this)
      .style("stroke", "none")
      .style("opacity", 0.8)
  }

  // add the squares
  svg.selectAll()
    .data(data, function(d) {return d.Day+':'+d.Type;})
    .enter()
    .append("rect")
      .attr("x", function(d) { return x(d.Day) })
      .attr("y", function(d) { return y(d.Type) })
      .attr("rx", 4)
      .attr("ry", 4)
      .attr("width", x.bandwidth() )
      .attr("height", y.bandwidth() )
      .style("fill", function(d) { return myColor(d.Value)} )
      .style("stroke-width", 4)
      .style("stroke", "none")
      .style("opacity", 0.8)
      .on("mouseover", function(event,d) {
        tooltip.transition()
          .duration(200)
          .style("opacity", .9);
        tooltip.html(d.Day + "<br>" + d.Type  + "<br>" +   d.Value )
        .style("left", d3.event.pageX  + "px")
        .style("top", d3.event.pageY + "px")
        })
      .on("mouseout", function(d) {
        tooltip.transition()
          .duration(500)
          .style("opacity", 0);
        });
})

// Add title to graph
svg.append("text")
    .attr("class", "title-bar")
        .attr("x", -65)
        .attr("y", -35)
        .attr("text-anchor", "left")
        .text("Type of Absence by Day of Week");

// Add subtitle to graph


        svg.selectAll("text.bar")
        .data(data)
      .enter().append("text")
        .attr("class", "text-bar")
        .attr("text-anchor", "left")
        .attr("fill", "white")
        .attr("x", function(d) { return x(d.Day) + 18; })
        .attr("y", function(d) { return y(d.Type) + 18; })
        .text(function(d) { return d.Value; });

}

drawheat()
        




d3.text("table1_PATHOLOGY.csv").then(function(datasetText) {
  var rows  = d3.csvParseRows(datasetText),
      table = d3.select('#table1').append('table')
               
      
      
  // headers
  table.append("thead").append("tr")
    .selectAll("th")
    .data(rows[0])
    .enter().append("th")
    .text(function(d) { return d; })
    .style("padding", "5px")
    .style("background", "rgb(253 253 255 / 5%)")
    .style("font-weight", "bold")
    .style("text-transform", "uppercase");

  // data
  table.append("tbody")
    .selectAll("tr").data(rows.slice(1))
    .enter().append("tr")
    .selectAll("td")
    .data(function(d){return d;})
    .enter().append("td")
    .style("padding", "5px")
    .on("mouseover", function(){
    d3.select(this).style("background", "powderblue");
  })
    .on("mouseout", function(){
    d3.select(this).style("background", "rgb(253 253 255 / 5%)");
  })
    .text(function(d){return d;})
    .style("font-size", "12px");



// Add subtitle to graph

});









const margin = {top: 90, right: 40, bottom: 20, left: 40},
    width = 1040 - margin.left - margin.right,
    height = 310 - margin.top - margin.bottom;

// append the svg object to the body of the page
const svg = d3.select("#big-graph")
  .append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform",`translate(${margin.left},${margin.top})`);

// Parse the Data
d3.csv("big_graph_PATHOLOGY.csv").then( function(data) {

  d3.csv("big_graph_PATHOLOGY2.csv",d3.autoType).then( function(data2) {


  



  // List of subgroups = header of the csv files = soil condition here
  const subgroups = data.columns.slice(1)

  // List of groups = species here = value of the first column called group -> I show them on the X axis
  const groups = data.map(d => d.week)

  
  
  
  var data33 ={"id" : 1, "second" : "abcd"};


  // Add X axis
  const x = d3.scaleBand()
      .domain(groups)
      .range([0, width])
      .padding([.25])
  svg.append("g")
    .attr("transform", `translate(0, ${height})`)
    .call(d3.axisBottom(x).tickSize(0));

  // Add Y axis
  const y = d3.scaleLinear()
    .domain([0,data2[0].n+1])
    .range([ height, 0 ]);
  svg.append("g")
    .call(d3.axisLeft(y).tickSize(0))
    .call(g => g.select(".domain").remove());

  // Another scale for subgroup position?
  const xSubgroup = d3.scaleBand()
    .domain(subgroups)
    .range([0, x.bandwidth()])
    .padding([0.15])

  // color palette = one color per subgroup
  const color = d3.scaleOrdinal()
    .domain(subgroups)
    .range([ "#69b3a2"])

  // Show the bars
  svg.append("g")
    .selectAll("g")
    // Enter in data = loop group per group
    .data(data)
    .join("g")
      .attr("transform", d => `translate(${x(d.week)}, 0)`)
    .selectAll("rect")
    .data(function(d) { return subgroups.map(function(key) { return {key: key, value: d[key]}; }); })
    .join("rect")
      .attr("x", d => xSubgroup(d.key))
      .attr("class", "bar")
      .attr("y", d => y(d.value))
      .attr("width", xSubgroup.bandwidth())
      .attr("height", d => height - y(d.value))
      .attr("fill", d => color(d.key));

      
    svg.append("text")
    .attr("class", "title-bar")
        .attr("x", 0)
        .attr("y", -60)
        .attr("text-anchor", "left")
        .text("Daily Absences");

// Add subtitle to graph
svg.append("text")
.attr("class", "subtitle-bar")
        .attr("x", 0)
        .attr("y", -40)
        .attr("text-anchor", "left")
        .text("February 2022");




        svg.selectAll("text.bar")
        .data(data)
      .enter().append("text")
        .attr("class", "text-bar3")
        .attr("fill", "White")
        .attr("x", -200)
        .attr("y",105)
        .attr("transform", "rotate(270)")
        .text("Monday");

        svg.selectAll("text.bar")
        .data(data)
      .enter().append("text")
        .attr("class", "text-bar3")
        .attr("fill", "White")
        .attr("x", -200)
        .attr("y",132)
        .attr("transform", "rotate(270)")
        .text("Tuesday");

        svg.selectAll("text.bar")
        .data(data)
      .enter().append("text")
        .attr("class", "text-bar3")
        .attr("fill", "White")
        .attr("x", -200)
        .attr("y",159)
        .attr("transform", "rotate(270)")
        .text("Wednesday");

        svg.selectAll("text.bar")
        .data(data)
      .enter().append("text")
        .attr("class", "text-bar3")
        .attr("fill", "White")
        .attr("x", -200)
        .attr("y",186)
        .attr("transform", "rotate(270)")
        .text("Thursday");

        svg.selectAll("text.bar")
        .data(data)
      .enter().append("text")
        .attr("class", "text-bar3")
        .attr("fill", "White")
        .attr("x", -200)
        .attr("y",213)
        .attr("transform", "rotate(270)")
        .text("Friday");











        
        svg.selectAll("text.bar")
        .data(data)
      .enter().append("text")
        .attr("class", "text-bar3")
        .attr("fill", "White")
        .attr("x", -200)
        .attr("y",332)
        .attr("transform", "rotate(270)")
        .text("Monday");

        svg.selectAll("text.bar")
        .data(data)
      .enter().append("text")
        .attr("class", "text-bar3")
        .attr("fill", "White")
        .attr("x", -200)
        .attr("y",359)
        .attr("transform", "rotate(270)")
        .text("Tuesday");

        svg.selectAll("text.bar")
        .data(data)
      .enter().append("text")
        .attr("class", "text-bar3")
        .attr("fill", "White")
        .attr("x", -200)
        .attr("y",386)
        .attr("transform", "rotate(270)")
        .text("Wednesday");

        svg.selectAll("text.bar")
        .data(data)
      .enter().append("text")
        .attr("class", "text-bar3")
        .attr("fill", "White")
        .attr("x", -200)
        .attr("y",413)
        .attr("transform", "rotate(270)")
        .text("Thursday");

        svg.selectAll("text.bar")
        .data(data)
      .enter().append("text")
        .attr("class", "text-bar3")
        .attr("fill", "White")
        .attr("x", -200)
        .attr("y",440)
        .attr("transform", "rotate(270)")
        .text("Friday");







         
        svg.selectAll("text.bar")
        .data(data)
      .enter().append("text")
        .attr("class", "text-bar3")
        .attr("fill", "White")
        .attr("x", -200)
        .attr("y",559)
        .attr("transform", "rotate(270)")
        .text("Monday");

        svg.selectAll("text.bar")
        .data(data)
      .enter().append("text")
        .attr("class", "text-bar3")
        .attr("fill", "White")
        .attr("x", -200)
        .attr("y",586)
        .attr("transform", "rotate(270)")
        .text("Tuesday");

        svg.selectAll("text.bar")
        .data(data)
      .enter().append("text")
        .attr("class", "text-bar3")
        .attr("fill", "White")
        .attr("x", -200)
        .attr("y",613)
        .attr("transform", "rotate(270)")
        .text("Wednesday");

        svg.selectAll("text.bar")
        .data(data)
      .enter().append("text")
        .attr("class", "text-bar3")
        .attr("fill", "White")
        .attr("x", -200)
        .attr("y",640)
        .attr("transform", "rotate(270)")
        .text("Thursday");

        svg.selectAll("text.bar")
        .data(data)
      .enter().append("text")
        .attr("class", "text-bar3")
        .attr("fill", "White")
        .attr("x", -200)
        .attr("y",667)
        .attr("transform", "rotate(270)")
        .text("Friday");





          
        svg.selectAll("text.bar")
        .data(data)
      .enter().append("text")
        .attr("class", "text-bar3")
        .attr("fill", "White")
        .attr("x", -200)
        .attr("y",783)
        .attr("transform", "rotate(270)")
        .text("Monday");

        svg.selectAll("text.bar")
        .data(data)
      .enter().append("text")
        .attr("class", "text-bar3")
        .attr("fill", "White")
        .attr("x", -200)
        .attr("y",810)
        .attr("transform", "rotate(270)")
        .text("Tuesday");

        svg.selectAll("text.bar")
        .data(data)
      .enter().append("text")
        .attr("class", "text-bar3")
        .attr("fill", "White")
        .attr("x", -200)
        .attr("y",837)
        .attr("transform", "rotate(270)")
        .text("Wednesday");

        svg.selectAll("text.bar")
        .data(data)
      .enter().append("text")
        .attr("class", "text-bar3")
        .attr("fill", "White")
        .attr("x", -200)
        .attr("y",864)
        .attr("transform", "rotate(270)")
        .text("Thursday");

        svg.selectAll("text.bar")
        .data(data)
      .enter().append("text")
        .attr("class", "text-bar3")
        .attr("fill", "White")
        .attr("x", -200)
        .attr("y",891)
        .attr("transform", "rotate(270)")
        .text("Friday");

})

})




var renderProgress = function(el) {
  var start = 0;
  var end = 100;
  
  var colours = {
    fill: '#855CF8',
    track: 'white',
    text: 'black',
    stroke: '#855CF8',
  }

  d3.csv("stats_PATHOLOGY.csv",d3.autoType).then( function(data33) {
  
  var radius = 100;
  var border = 40;
  var strokeSpacing = 1.5;
  var endAngle = Math.PI * 2 * data33[0].absent_rate2
  var formatText = d3.format('.0%');
  var boxSize = radius * 3;
  var count = end;
  var progress = start;
  var step = end < start ? -0.01 : 0.01;


  console.log(Math.PI * 2 *data33[0].absent_rate2)


  
  //Define the circle
  var circle = d3.arc()
    .startAngle(0)
    .innerRadius(radius)
    .outerRadius(radius - border);


    var circle2 = d3.arc()
    .startAngle(0)
    .innerRadius(60)
    .outerRadius(0);
  
  //setup SVG wrapper
  var svg = d3.select(el)
    .append('svg')
    .attr('width', boxSize)
    .attr('height', boxSize);
  
  // ADD Group container
  var g = svg.append('g')
    .attr('transform', 'translate('  + boxSize / 2 + ',' + boxSize / 2.5 + ')');
  
  //Setup track
  var track = g.append('g').attr('class', 'radial-progress');
  track.append('path')
    .attr('class', 'radial-progress__background')
    .attr('fill', colours.track)
    .attr('opacity', '.85')
    .attr('stroke', colours.stroke)
    .attr('stroke-width', strokeSpacing + 'px')
    .attr('d', circle.endAngle(endAngle));

    var track = g.append('g').attr('class', 'radial-progress');
  track.append('path')
    .attr('class', 'radial-progress__background')
    .attr('fill', 'none')
    .attr('opacity', '.85')
    .attr('stroke', colours.stroke)
    .attr('stroke-width', strokeSpacing + 'px')
    .attr('d', circle2.endAngle(Math.PI* 2));
  
  
  //Add colour fill
  var value = track.append('path')
    .attr('class', 'radial-progress__value')
    .attr('fill', colours.fill)
    .attr('opacity', '.15')
    .attr('stroke', colours.stroke)
    .style("stroke-linecap", "square")  
    .style("border", "1px")  
    .attr('stroke-width', strokeSpacing + 'px');


   
  
  //Add text value
  var numberText = track.append('text')
    .attr('class', 'radial-progress__text')
    .attr('fill', colours.text)
    .attr('font-size', '150px')
    .attr('text-anchor', 'middle')
    .attr('dy', '.5rem');


  

    
  
  function update(progress) {
    //update position of endAngle
    value.attr('d', circle.endAngle(endAngle * progress));
    //update text value
    numberText.text(formatText(data33[0].absent_rate2));

    
  };
  
  function iterate() {
    //call update to begin animation
    update(progress);
    
    if (count > 0) {
      //reduce count till it reaches 0
      count--;
      //increase progress
      progress += step;
      //Control the speed of the fill
      setTimeout(iterate, 10);
    }
  };
  
  iterate();

})
}

Array.prototype.slice.call(document.querySelectorAll('.progress')).forEach(el => {
  renderProgress(el);
});