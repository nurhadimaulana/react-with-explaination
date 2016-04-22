# create react class called RecordForm
@RecordForm = React.createClass
  # will generate the initial state of the components
  getInitialState: ->
    title: ''
    date: ''
    amount: ''

  # checking whether title date and amout value is not empty
  valid: ->
    @state.title && @state.date && @state.amount

  # change value of a state whenever there is any change with the input
  # setState will perform schedules a UI verification/refresh based on the new state
  # where using @state is just set old state to new state everytime it called
  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value

  # process the form when the form is submitted
  handleSubmit: (e) ->
    e.preventDefault()
    $.post '', { record: @state }, (data) =>
      # success callback
      # trigger handleNewRecord method > addRecord in Records class
      # purpose of this action is to add new record to existing records state
      @props.handleNewRecord data
      # trigger getInitialState method for setState action - use @ because in the same file
      # purpose of this action is to make all text field value become empty
      @setState @getInitialState()
    , 'JSON'

  # render this react DOM when calling this react class named RecordForm
  render: ->
    React.DOM.form
      className: 'form-inline'
      # will trigger handleSubmit method when form is submitted
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Date'
          name: 'date'
          value: @state.date
          # will trigger handleChange method when input is changed
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Title'
          name: 'title'
          value: @state.title
          # will trigger handleChange method when input is changed
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'number'
          className: 'form-control'
          placeholder: 'Amount'
          name: 'amount'
          value: @state.amount
          # will trigger handleChange method when input is changed
          onChange: @handleChange
      React.DOM.button
        type: 'submit'
        className: 'btn btn-primary'
        disabled: !@valid()
        'Create record'