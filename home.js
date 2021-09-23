







d3.text("all_stats_2.csv").then(function(datasetText) {
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
      .html(function(d){return d;})
      .style("font-size", "12px");
  
  
  
  // Add subtitle to graph
  
  });