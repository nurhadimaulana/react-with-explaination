# create react class / component called Records
@Records = React.createClass

  # will generate the initial state of the component
  getInitialState: ->
    records: @props.data

  # initialize component's properties in case we forget to send any data when instantiating it
  getDefaultProps: ->
    records: []

  # method to handle adding new record added to existing records and setState of records
  # in this case - this method is aliasing as handleNewRecord - binding to RecordForm element
  # so RecordForm could call this addRecord as @props.handleNewRecord and bring one parameter
  addRecord: (record) ->
    # records = @state.records.slice()
    # records.push record
    # @setState records: records
    # refactoring - use react addons - dont forget to set react addons to be true on config/application.rb
    records = React.addons.update(@state.records, { $push: [record] })
    @setState records: records

  # method to handle update record
  updateRecord: (record, data) ->
    index = @state.records.indexOf record
    # ??? find out what is splice
    records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
    @replaceState records: records

  # method to handle delete record process
  # get index of deleted record and then remove it
  # replace state of old records with new records which has deleted one record
  deleteRecord: (record) ->
    # records = @state.records.slice()
    # index = records.indexOf record
    # records.splice index, 1
    # @replaceState records: records
    # refactoring - use react addons - dont forget to set react addons to be true on config/application.rb
    index = @state.records.indexOf record
    records = React.addons.update(@state.records, { $splice: [[index, 1]] })
    @replaceState records: records

  # create a new method called credits
  credits: ->
    # create a new property called credits and put filtered records which has amount more than or equal to 0
    credits = @state.records.filter (val) -> val.amount >= 0
    credits.reduce ((prev, curr) ->
      prev + parseFloat(curr.amount)
    ), 0

  # create a new method called debits
  debits: ->
    # create a new property called debits and put filtered records which has amount less than 0
    debits = @state.records.filter (val) -> val.amount < 0
    debits.reduce ((prev, curr) ->
      prev + parseFloat(curr.amount)
    ), 0

  # create a new method called balance and the return of this method is sum of debits() and credits()
  balance: ->
    @debits() + @credits()


  # render this react DOM when calling this react class named Records
  render: ->
    React.DOM.div
      className: 'records'
      React.DOM.h2
        className: 'title'
        'Records'
      React.DOM.div
        className: 'row'
        # calling AmountBox class and add a property called type, amount and text with their own value
        React.createElement AmountBox, type: 'success', amount: @credits(), text: 'Credit'
        React.createElement AmountBox, type: 'danger', amount: @debits(), text: 'Debit'
        React.createElement AmountBox, type: 'info', amount: @balance(), text: 'Balance'

      # calling RecordForm class and add a method called handleNewRecord with addRecord functionality
      React.createElement RecordForm, handleNewRecord: @addRecord
      React.DOM.hr null
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'Date'
            React.DOM.th null, 'Title'
            React.DOM.th null, 'Amount'
            React.DOM.th null, 'Actions'
        React.DOM.tbody null,
          # iteration of record data content
          for record in @state.records
            # displaying data by calling class Record and bring key & record data
            # When we handle dynamic children (in this case, records) we need to provide a key property
            # to the dynamically generated elements so React won't have a hard time refreshing our UI
            # that's why we send key: record.id along with the actual record when creating Record elements.
            # If we don't do so, we will receive a warning message in the browser's JS console
            # (and probably some headaches in the near future).
            React.createElement Record, key: record.id, record: record, handleDeleteRecord: @deleteRecord, handleEditRecord: @updateRecord