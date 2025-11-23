
ui <- fluidPage(
  theme = bs_theme(version = 4),
  tags$head(
    tags$meta(charset = "utf-8"),
    tags$meta(name = "viewport", content = "width=device-width, initial-scale=1, shrink-to-fit=no"),
    # Feather icons and Chart.js (CDN)
    tags$script(src = "https://unpkg.com/feather-icons/dist/feather.min.js"),
    tags$script(src = "https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js"),
    # Minimal CSS to replicate the Bootstrap 4 dashboard example
    tags$style(HTML("
      body {
        font-size: .875rem;
      }
      .feather {
        width: 16px;
        height: 16px;
      }
      .navbar {
        box-shadow: 0 0.125rem 0.25rem rgba(0,0,0,.075);
      }
      .navbar-brand {
        padding-top: .75rem;
        padding-bottom: .75rem;
        font-size: 1rem;
      }
      .form-control {
        padding: .75rem 1rem;
      }
      .sidebar {
        position: fixed;
        top: 56px; /* height of fixed-top navbar */
        bottom: 0;
        left: 0;
        z-index: 100; /* stay above content */
        padding: 0;
        box-shadow: inset -1px 0 0 rgba(0, 0, 0, .1);
      }
      .sidebar-sticky {
        position: -webkit-sticky;
        position: sticky;
        top: 0; /* stick below navbar */
        height: calc(100vh - 56px);
        padding-top: .5rem;
        overflow-x: hidden;
        overflow-y: auto;
      }
      .sidebar .nav-link {
        font-weight: 500;
        color: #333;
      }
      .sidebar .nav-link .feather {
        margin-right: 4px;
        color: #727272;
      }
      .sidebar .nav-link.active {
        color: #007bff;
      }
      .sidebar .nav-link:hover .feather,
      .sidebar .nav-link.active .feather {
        color: inherit;
      }
      .sidebar-heading {
        font-size: .75rem;
        text-transform: uppercase;
      }
      [role=\"main\"] {
        padding-top: 56px; /* space for fixed navbar */
      }
      .border-bottom {
        border-bottom: 1px solid #dee2e6 !important;
      }
      .table-responsive {
        margin-top: 1rem;
      }
      .btn-toolbar .btn-group .btn {
        margin-right: .5rem;
      }
    "))
  ),
  
  # Top navbar
  tags$nav(
    class = "navbar navbar-dark bg-dark fixed-top d-flex justify-content-between",
    
    # Left side: brand
    tags$a(class = "navbar-brand col-sm-3 col-md-2 mr-0", href = "#", "centsair"),
    
    # Right side: Help and Data refresh
    tags$ul(
      class = "navbar-nav ml-auto d-flex flex-row",
      
      # Help link
      tags$li(class = "nav-item text-nowrap",
              tags$a(class = "nav-link", href = "#", "Help")),
      
      # Last data refresh
      tags$li(class = "nav-item text-nowrap",
              tags$span(class = "nav-link", "Last data refresh on 2025-11-23"))
    )
  ),
  
  # Page layout
  div(
    class = "container-fluid",
    div(
      class = "row",
      # Sidebar
      div(
        class = "col-md-2 d-none d-md-block bg-light sidebar",
        div(
          class = "sidebar-sticky",
          tags$ul(
            class = "nav flex-column",
            tags$li(class = "nav-item",
                    tags$a(class = "nav-link active", href = "#",
                           tags$span(`data-feather` = "home"), " Dashboard ",
                           span(class = "sr-only", "(current)")
                    )
            ),
            tags$li(class = "nav-item",
                    tags$a(class = "nav-link", href = "#",
                           tags$span(`data-feather` = "file"), " Orders")
            ),
            tags$li(class = "nav-item",
                    tags$a(class = "nav-link", href = "#",
                           tags$span(`data-feather` = "shopping-cart"), " Products")
            ),
            tags$li(class = "nav-item",
                    tags$a(class = "nav-link", href = "#",
                           tags$span(`data-feather` = "users"), " Customers")
            ),
            tags$li(class = "nav-item",
                    tags$a(class = "nav-link", href = "#",
                           tags$span(`data-feather` = "bar-chart-2"), " Reports")
            ),
            tags$li(class = "nav-item",
                    tags$a(class = "nav-link", href = "#",
                           tags$span(`data-feather` = "layers"), " Integrations")
            )
          ),
          tags$h6(class = "sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted",
                  tags$span("Saved reports"),
                  tags$a(class = "d-flex align-items-center text-muted", href = "#",
                         tags$span(`data-feather` = "plus-circle"))
          ),
          tags$ul(
            class = "nav flex-column mb-2",
            tags$li(class = "nav-item",
                    tags$a(class = "nav-link", href = "#",
                           tags$span(`data-feather` = "file-text"), " Current month")
            ),
            tags$li(class = "nav-item",
                    tags$a(class = "nav-link", href = "#",
                           tags$span(`data-feather` = "file-text"), " Last quarter")
            ),
            tags$li(class = "nav-item",
                    tags$a(class = "nav-link", href = "#",
                           tags$span(`data-feather` = "file-text"), " Social engagement")
            ),
            tags$li(class = "nav-item",
                    tags$a(class = "nav-link", href = "#",
                           tags$span(`data-feather` = "file-text"), " Year-end sale")
            )
          )
        )
      ),
      
      # Main content
      tags$main(
        role = "main",
        class = "col-md-9 ml-sm-auto col-lg-10 px-4",
        
        div(
          class = "d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom",
          tags$h1(class = "h2", "Dashboard"),
          
          div(
            class = "btn-toolbar mb-2 mb-md-0",
            tags$button(type = "button", class = "btn btn-sm btn-outline-secondary dropdown-toggle",
                        tags$span(`data-feather` = "calendar"),
                        "This week")
          )
        ),
        
        # Chart area
        tags$canvas(id = "myChart", class = "my-4 w-100", width = "900", height = "380"),
        
        tags$h2("Section title"),
        div(
          class = "table-responsive",
          tags$table(
            class = "table table-striped table-sm",
            tags$thead(
              tags$tr(
                tags$th("#"),
                tags$th("Header"),
                tags$th("Header"),
                tags$th("Header"),
                tags$th("Header")
              )
            ),
            tags$tbody(
              lapply(1:15, function(i) {
                tags$tr(
                  tags$td(i),
                  tags$td("Lorem ipsum dolor"),
                  tags$td("sit amet"),
                  tags$td("consectetur"),
                  tags$td("adipiscing")
                )
              })
            )
          )
        )
      )
    )
  ),
  
  # Init feather icons and demo chart
  tags$script(HTML("
    document.addEventListener('DOMContentLoaded', function() {
      if (window.feather) feather.replace();

      var ctx = document.getElementById('myChart');
      if (ctx && window.Chart) {
        var myChart = new Chart(ctx, {
          type: 'line',
          data: {
            labels: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
            datasets: [{
              data: [15339, 21345, 18483, 24003, 23489, 24092, 12034],
              lineTension: 0,
              backgroundColor: 'transparent',
              borderColor: '#007bff',
              borderWidth: 2,
              pointBackgroundColor: '#007bff'
            }]
          },
          options: {
            scales: {
              yAxes: [{
                ticks: { beginAtZero: false }
              }]
            },
            legend: { display: false }
          }
        });
      }
    });
  "))
)
