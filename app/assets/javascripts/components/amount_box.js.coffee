# create react class / component called Records
@AmountBox = React.createClass
  # render this react DOM when calling this react class named AmountBox
  render: ->
    React.DOM.div
      className: 'col-md-4'
      React.DOM.div
        # @props.type is taken from what we set on property when creating this AmountBox component element
        className: 'panel panel-#{ @props.type }'
        React.DOM.div
          className: 'panel-heading'
          @props.text
        React.DOM.div
          className: 'panel-body'
          # this amount taken dynamically based on what we put on property value for amount
          amountFormat(@props.amount)