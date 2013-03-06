namespace 'SensuDashboard', (exports) ->

  class exports.Bootstrapper

    constructor: (options = {}) ->
      @successCallback = options.success
      @errorCallback = options.error

      try
        $.ajax
          type: 'GET'
          url: '/all'
          context: this
          dataType: 'json'
          success: (data, textStatus, jqXHR) ->
            console.log data
            SensuDashboard.Stashes = new SensuDashboard.Collections.Stashes(data['stashes'])
            SensuDashboard.Events = new SensuDashboard.Collections.Events(data['events'])
            SensuDashboard.EventsMetadata = new SensuDashboard.Models.Metadata.Events
            SensuDashboard.EventsView = new SensuDashboard.Views.Events.Index

            @successCallback.call(this)
          error: (jqXHR, textStatus, errorThrown) ->
            console.log jqXHR.status+' '+jqXHR.statusText
            console.log errorThrown
            console.log textStatus
            console.log jqXHR
            @error()

      catch error
        @error()

    error: ->
      @errorCallback.call(this)
      return
