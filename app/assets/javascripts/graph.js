window.addEventListener("load", function(){
  let form = document.querySelector(".search-box");

  form.addEventListener("ajax:success", function(event){    
    let word = document.querySelector("#name").value.toLowerCase();

    Rails.ajax({
      type: "GET", 
      url: "/words/" + word,
      success: function(response) { createGraph(response) }
    })
  })
  
  function createGraph(data) {
    var canvas = document.querySelector("canvas"),
    context = canvas.getContext("2d"),
    width = canvas.width;
    height = canvas.height;
  
    var simulation = d3.forceSimulation()
        .force("link", d3.forceLink().id(function(d) { return d.id; }))
        .force("charge", d3.forceManyBody().strength(-3000))
        .force("center", d3.forceCenter());
        
    var graph = data;
  
    simulation
      .nodes(graph.nodes)
      .on("tick", ticked);
  
    simulation.force("link")
      .links(graph.links);
  
    function ticked() {
      context.clearRect(0, 0, width, height);
      context.save();
      context.translate(width / 2, height / 2 + 40);
  
      context.beginPath();
      graph.links.forEach(drawLink);
      context.strokeStyle = "#aaa";
      context.stroke();
  
      context.beginPath();
      graph.nodes.forEach(drawNode);
      context.fill();
      context.strokeStyle = "#fff";
      context.stroke();
  
      context.restore();
    }
  
    function drawLink(d) {
      context.moveTo(d.source.x, d.source.y);
      context.lineTo(d.target.x, d.target.y);
    }
  
    function drawNode(d) {
      context.moveTo(d.x + 3, d.y);
      context.arc(d.x, d.y, 6, 0, 2 * Math.PI);
      
      var size = context.measureText(d.id);
      context.font = "15px Georgia";
      context.fillText(d.id, d.x - size.width/2, d.y + 15)
    }
  }
})

