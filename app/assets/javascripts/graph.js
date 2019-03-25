window.addEventListener("load", function(){
  let form = document.querySelector(".search-box");
  let wordInput = document.querySelector("#name");

  form.addEventListener("ajax:success", function(event){   
    word = wordInput.value.toLowerCase(); 
    Rails.ajax({
      type: "GET", 
      url: "/words/" + word,
      success: function(response) { createGraph(response) }
    })
  })
  
  function createGraph(data) {

    d3.select(".graph-container").selectAll("svg").remove()
    var svg = d3.select(".graph-container").append("svg")
  
    var simulation = d3.forceSimulation()
      .force("link", d3.forceLink().id(function(d) { return d.id }))
      .force("charge", d3.forceManyBody().strength(-3000))
      .force("center", d3.forceCenter(600,600));

    var link = svg.append("g")
      .attr("class", "links")
      .selectAll("line")
      .data(data.links)
      .enter()
      .append("line")
      .attr("stroke", "#cecece")

    var node = svg.append("g")
      .attr("class", "nodes")
      .selectAll(".node")
      .data(data.nodes)
      .enter().append("g")
      .attr("class", "node")
      .on("click", function(ev) {
        wordInput.value = d3.select(this).text();
        Rails.ajax({
          type: "POST", 
          url: "/words",
          data: "name="+wordInput.value,
          success: function(response) { 
            Rails.ajax({
              type: "GET", 
              url: "/words/" + wordInput.value,
              success: function(response) { createGraph(response) }
            }) 
          }
        })
      })
      
    node.append('circle')
        .attr("class", function(d) { return d.id.toLowerCase() == wordInput.value.toLowerCase() ? "input" : "related" })
        .attr("r", 6)
        
    node.append("text")
        .attr("dx", 0)
        .attr("dy", "1em")
        .attr("width", "50px")
        .attr("height", "12m")
        .text(function(d) { return d.id; });
  
    var ticked = function() {
      link
          .attr("x1", function(d) { return d.source.x; })
          .attr("y1", function(d) { return d.source.y; })
          .attr("x2", function(d) { return d.target.x; })
          .attr("y2", function(d) { return d.target.y; });

      node
          .attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; })
  }

    simulation
      .nodes(data.nodes)
      .on("tick", ticked);
  
    simulation.force("link")
      .links(data.links);
  }
})

