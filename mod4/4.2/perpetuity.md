Coursera: Financial Evaluation and Strategy: Investments  
Exercise for module 4.2  
Rob Alderman   
Sep 2015


## Perpetuity Valuations

A ***perpetuity*** is a stream of (typically identical) cash flows that lasts indefinitely.
Despite the fact the stream of payments is infinite, the **present value** of a perpetuity
is finite, due to the fact future cash flows are discounted back to the present according
to the interest rate/discount rate.  Each future cash payment is a smaller and smaller fraction
of the present value.  On a long enough timeline, the present value of future payments drops to zero.

An example are British consols, which give the buyer an infinite stream of interest payments.

The perpetuity formula:

$$
\begin{align*}
PV &= \frac{CF_1}{(1+r)} + \frac{(1+g)CF_1}{(1+r)^2} + \frac{(1+g)^2CF_1}{(1+r)^3} + \frac{(1+g)^3CF_1}{(1+r)^4} + \cdots
\\\\
PV &= \frac{CF_1}{r-g}
\end{align*}
$$

<ul>
<li>PV = present value of the perpetuity</li>
<li>\(CF_1\) = cash flow in period 1</li>
<li>r = interest/discount rate </li>
<li>g = cash flow growth rate</li>
</ul>

**Note:** the formula only works if r > g.  If g > r, then the PV is essentially infinite.  g > r
means the cash flow will grow faster than the discount rate, which means the summation (first equation)
doesn't converge to a limit (future payments get larger and larger, not smaller and smaller).

Higher discount rates, r, mean lower present value, since the asset/perpetuity is expected to yield a high
rate-of-return, therefore needs a lower present investment in order to meet future value expectations.  

Lower discount rates mean higher present value, since the expected yield is lower and therefore requires a
higher present investment to make expected payouts in the future.

Higher growth rates, g, mean higher present value.  This is straightforward.  Another way to think about
it is that the growth rate cuts into the discount rate (r-g in the denominator).  An investment made
today with a rate-of-return of r (and no growth rate) needs to be higher (higher PV) in order to match an investment
made today with rate-of-return r plus a growth rate.  The growth rate is growth-in-return above and beyond
the interest rate.



<br />
### Question 1

Suppose an asset yields $100 per year (first payment occurring next year).  
The interest rate is 10%.  
What is the value of this perpetuity?  
What fraction of the perpetuity value is represented by the first 5 payments?  



```r
r <- 0.10
g <- 0
cf.1 <- 100

# pv of perpetuity
pv <- cf.1 / (r - g)
pv
```

```
## [1] 1000
```

```r
# first 5 payments
pv.5 <- Reduce( function(memo, i) { memo + cf.1 / (1+r)^i }, 1:5, 0 )
pv.5
```

```
## [1] 379.0787
```

```r
pv.5 / pv
```

```
## [1] 0.3790787
```

The PV is $1000.  
The first 5 payments represent ~37.9% of the total value.


<br />
### Question 2

Suppose an asset yields $100 per year (first payment occurring next year).  
The interest rate is 10%.  
What happens to the value of the perpetuity if the interest rate falls to 5%?  
What happens to the value of the perpetuity if the cash flow grows at 3% (interest rate = 10%)?  
What happens to the value of the perpetuity if the cash flow grows at 5% (interest rate = 10%)?  


```r
r <- 0.05
g <- 0
cf.1 <- 100

pv <- cf.1 / (r - g)
pv
```

```
## [1] 2000
```

```r
r <- 0.10
g <- 0.03

pv <- cf.1 / (r - g)
pv
```

```
## [1] 1428.571
```

```r
g <- 0.05
pv <- cf.1 / (r - g)
pv
```

```
## [1] 2000
```

When the interest rate falls by half (10% -> 5%), the value of the perpetuity doubles from $1000 to $2000.   
When cash flow (yield) grows by 3%, the value of the perpetuity rises by 0.1 / 0.07: $1429

$$
\begin{align*}
PV_a &= \frac{CF_1}{r-g_a}
\\\\
PV_b &= \frac{CF_1}{r-g_b}
\\\\
\frac{PV_a}{PV_b} &= \frac{ \frac{CF_1}{r-g_a} }{ \frac{CF_1}{r-g_b} }
\\\\
\frac{PV_a}{PV_b} &= \frac{ r-g_b }{ r-g_a }
\\\\
PV_a &= PV_b \cdot \frac{ r-g_b }{ r-g_a }
\end{align*}
$$


When cash flow (yield) grows by 5%, the value of the perpetuity doubles (0.10 / 0.05) to $2000.



