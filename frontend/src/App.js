import React, { Component } from 'react';
import './App.css';

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      resources: [],
    };
  }

  componentDidMount() {
    fetch("http://localhost:80/api/resources")
	  .then(response => response.json())
	  .then(data => this.setState({ resources: data }));
  }

  render() {
    const { resources } = this.state;

    return (
      <div className="App">
        <header className="App-header">
	  <table className="resources-list">
	    {resources.map(resource => {
            	return  <tr>
			    <td className="resource-title">
				{resource.title}
		    	    </td>
			    <td className="download-link">
			        <a href={"http://localhost:80/api/resource/" + resource.id} download={resource.id}>Download</a>
			    </td>
			</tr>
	    	  }
	    	)
	    }
	  </table>
        </header>
      </div>
    );
  }
}

export default App;
