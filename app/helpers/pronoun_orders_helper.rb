module PronounOrdersHelper
    def create_tag(state)
        if state === "order placed"
            return "<span class='tag label label-primary'>"+ state +"</span>".html_safe
        elsif state === "Ready For Pickup"
            return "<span class='tag label label-info'>"+ state +"</span>".html_safe
        elsif state === "Accept"
            return "<span class='tag label label-success'>"+ state +"</span>".html_safe
        elsif state === "Reject"
            return "<span class='tag label label-danger'>"+ state +"</span>".html_safe
        elsif state === "Revise"
            return "<span class='tag label label-warning'>"+ state +"</span>".html_safe
        else
            return "<span class='tag label label-default'>"+ state +"</span>".html_safe
        end
    end
end
