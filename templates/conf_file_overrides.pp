# Managed by Puppet.

set daemon <%= @check_interval %>
    with start delay <%= @check_start_delay %>

set logfile <%= @logfile %>
<% if @mailserver %>
set mailserver <%= @mailserver %>
<% end -%>
<% if @eventqueue %>
set eventqueue
    basedir <%= @eventqueue_basedir %>
    slots <%= @eventqueue_slots %>
<% end -%>
<% if @mmonit_url %>
set mmonit <%= @mmonit_url %>
<% end -%>

set mail-format {
    from: <%= @mailformat_from %>
<% if @mailformat_replyto -%>
    reply-to: <%= @mailformat_replyto %>
<% end -%>
<% if @mailformat_subject -%>
    subject: <%= @mailformat_subject %>
<% end -%>
<% if @mailformat_message -%>
    message: <%= @mailformat_message %>
<% end -%>
}

<% if @alert -%>
  <%- @alert.each do |item| -%>
set alert <%= item %>
  <%- end -%>
<% end -%>

<% if @httpserver -%>
set httpd
    port <%= @httpserver_port %>
    signature disable
  <%- if @httpserver_bind_address -%>
    use address <%= @httpserver_bind_address %>
  <%- end -%>
  <%- if @httpserver_ssl and @httpserver_pemfile -%>
    ssl enable
    pemfile <%= @httpserver_pemfile %>
  <%- end -%>
  <%- if @httpserver_allow -%>
    <%- @httpserver_allow.each do |allow| %>
    allow <%= allow %>
    <%- end -%>
  <%- end -%>
<% end -%>

