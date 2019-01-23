import React, { Component } from 'react';
import './App.css';

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      resources: [],
      isLoading: true,
      isError: false,
    };
  }

  componentDidMount() {
    fetch("http://localhost:80/api/resources")
	  .then(response => {
		if (response.ok) {
		  response.json()
		} else {
		  throw Error(response.statusText);
		}
	  })
	  .then(data => this.setState({ isLoading: false, isError: false, resources: data }))
	  .catch(error => {
	     console.log(error)
	     this.setState({ isLoading: false, isError: true, resources: [] })
	  });
  }

  render() {
    const { resources, isLoading, isError } = this.state;

    if (isLoading) {
	return (
      		<div className="App">
      		  <header className="App-header">
		    <p>Loading data...</p>
      		  </header>
      		</div>
	);
    }

    if (isError) {
	return (
      		<div className="App">
      		  <header className="App-header">
      		    <p>An error occurred, please retry...</p>
      		  </header>
      		</div>
	);
    }

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
