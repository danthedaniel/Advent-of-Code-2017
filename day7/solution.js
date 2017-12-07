var fs = require('fs');

var parent_node = function(tree, node) {
    var parent = tree.edges.find(edge => edge[1] === node);
    return parent ? parent[0] : null;
};

var root_node = function(tree) {
    var node = Object.keys(tree.nodes)[0];
    while (node) {
        var parent = parent_node(tree, node);
        if (parent) { node = parent; } else { return node; }
    }
    return null;
};

var solve = function(input) {
    var tree = {nodes: {}, edges: []};
    input.
        map(line => {
            var pattern = /([a-z]+) \((\d+)\)(?: -> ((?:[a-z]+(?:, )?)+))?/g;
            return pattern.exec(line);
        }).
        forEach(group => {
            var node_name = group[1];
            var weight = parseInt(group[2]);
            var outgoing_edges = group[3] ? group[3].split(', ') : [];
            // Add the node to the tree
            tree.nodes[node_name] = weight;
            // Add all outgoing edges to the tree
            outgoing_edges.forEach(to => {
                var edge = [node_name, to];
                tree.edges.push(edge);
            });
        });

    console.log('Root: ' + root_node(tree));
};

fs.readFile('input', 'utf8', function (err, data) {
    if (err) {
        console.error(err);
    } else {
        var input_lines = data.split('\n').filter(line => line.length > 0);
        solve(input_lines);
    }
});
