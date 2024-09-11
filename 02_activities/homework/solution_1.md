# Homework # 1 - Solution

## Using Mermaid

This diagram was created in Markdown using just words thanks to GitHub's [Mermaid](https://github.com/mermaid-js/mermaid) [support](https://github.blog/developer-skills/github/include-diagrams-markdown-files-mermaid/). 

Using Mermaid in Markdown on GitHub means there is no need to embed an image. Moreover, it's easy to see what changed in the model between versions. You can see the graphical representation on GitHub, or with a Mermaid editor like [Mermaid Live Editor](https://mermaid.live/) or [Mermaid Chart](https://www.mermaidchart.com/).

But if you still want to see an embedded image, go the next [section](#).

```mermaid
---
title: Farmers Market Logical Model (partial)
---
erDiagram

  customer {
    _ customer_id
    _ customer_first_name
    _ customer_last_name
    _ customer_zip
  }


  customer_purchases {
    _ product_id
    _ vendor_id
    _ market_date
    _ customer_id
    _ quantity
    _ cost_to_customer_per_qty
    _ transaction_time
  }

  customer ||--o{ customer_purchases : ""

```

## Using an Embedded Image

![Image of the Farmers Market - Logical Model (partial)](images/solution_1.png "Farmers Market - Logical Model (partial)")
