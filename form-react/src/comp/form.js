import React from 'react';
import ReactDOM from 'react-dom';
import './form.css';


class Form extends React.Component{
 constructor(props){
    super(props);
	this.state={
  				fname:'',
  				lname:'',
  				appAddress:'',
};

}

ChangeHandler=(event)=>{
var nam=event.target.appname;
var val=event.target.appAddress
this.setState({[nam]: val});
}

	render(){
		return(
	<div id='cen'>
	<form id="form">  
	<fieldset>

	<h1>Registration Form</h1>
	
  	<h2>Name of applicant</h2>

	<div id="fullName">
                <input type="text" name="fName" id="fname" placeholder="First Name" required  onChange={this.ChangeHandler}   />
                <input type="text" name="lName" id="lname" placeholder="Last Name" required    onChange={this.ChangeHandler}  />
              </div>

 
   <h2>Address</h2>  
<div id='sub'>   
<input
types= 'address'
name='appAddress'
placeholder="Street Address:"
 required
onChange={this.ChangeHandler}
/>
<input
types= 'email'
name='email'
placeholder='email@gmail.com'
onChange={this.ChangeHandler}
/>
<input
 type="tel"
  name="phone" id="phone"
   placeholder="Telephone Number" 
   required 
   onChange={this.ChangeHandler}
/>

</div>
<br/>
<h2> Date of Birth</h2>
<div id='sub'>  
<input
types= 'date'
name='bdate'
placeholder="MM-DD-YYYY" required
onChange={this.ChangeHandler}
/>
  </div>
  <br/>
   <h2>Gender</h2>
    <div id='sub'> 
<input
types= 'text'
name='appAddress'
onChange={this.ChangeHandler}
/>
</div>
<br /><br />
              <input
               type="submit"
                name="submit"
                 id="submit"
                  />

</fieldset>
  </form>
  </div>
		)
	}

}
export default Form;