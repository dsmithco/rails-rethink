class Input extends React.Component {
  render () {
    return (
      <div>
        <input
               className="form-control"
               name={this.props.name}
               value={this.props.value}
               type={this.props.type||'text'}
               value={this.props.value}/>
      </div>
    );
  }
}

Input.propTypes = {
  name: React.PropTypes.string,
  type: React.PropTypes.string
};
