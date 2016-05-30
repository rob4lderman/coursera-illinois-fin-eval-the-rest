Coursera: Financial Evaluation and Strategy: Investments  
Exercise for module 4.6  
Rob Alderman   
Sep 2015


## Valuing pension plans

Many state govts and some firms have DEFINED BENEFIT PENSION PLANS.  

***Defined Benefit***: the annuity payment is fixed ahead of time based on factors
such as worker age, salary, etc.

The state/firm must (presently) accumulate assets in its pension plan in order to meet the (future)
liabilities of these pension plans.

How do you value the cost of this stream of future payments (the pension plans) today (present value)?

**Key questions:**

1. which discount rate to use to convert future costs into present value today?
2. does the asset investment strategy (e.g. higher vs lower risk) influence the value of the pension's liabilities?

<br />
### Example: CalPERS: California Public Employee Retirement System

* largest public defined benefit pension plan
* $300B assets (May 2015)
* $50B lost in 2009 (20%)

Stanford study (2010): CalPERS assets cover only 50% of projected liabilities.  The study used a discount rate
of 4%, equal to the 10-year Treasury rate, which is essentially a risk-free rate.

CalPERS in fact has been earning 7.9% annualized return over the last 40 years.  The fund responded to the 
Standford study by saying the discount rate they used was too low.  If you instead use a 7.5% discount rate, 
CalPERS assets cover 86% of future liabilities.

The choice of discount rate is important when computing present value.  For example, assume $100 (Defined Benefit) 
is paid out 5, 10, 20 years from now.  What's the present value of this cash flow using a discount rate of 4% vs 8%:


```r
r4 <- 0.04
r8 <- 0.08

r4.5 <- 100 / (1+r4)^5
r4.10 <- 100 / (1+r4)^10
r4.20 <- 100 / (1+r4)^20

r8.5 <- 100 / (1+r8)^5
r8.10 <- 100 / (1+r8)^10
r8.20 <- 100 / (1+r8)^20

c(r4.5, r4.10, r4.20)
```

```
## [1] 82.19271 67.55642 45.63869
```

```r
c(r8.5, r8.10, r8.20)
```

```
## [1] 68.05832 46.31935 21.45482
```

A *higher* discount rate gives you a *lower* present value.  In other words, the future cash flows from the annuity
have a *lower* present value when the discount rate is *higher*.  Why?  Because the discount rate is the implied
rate-of-return that you could receive on an alternate investment.  The higher the rate-of-return, the lower your
investment needs to be today to meet some target future value.   The lower the rate-of-return, the higher your
investment needs to be today to meet the target future value (since your investment is earning a lower rate-of-return).

In the CalPERS case, we know the future value (technically the future *liability*), since we're talking about **defined benefit** plans.  The pension plan
fund manager is trying to meet a known future value liability (the pre-defined payments).  The fund currently
has some amount of assets (their portfolio).  Those assets have a known present value.  The rate-of-return on those assets is 
unknown -- unless all assets are bond-like instruments with risk-free fixed returns (e.g. risk-free treasury bonds).  If
the assets are a mix of stocks and bonds, the rate-of-return on bonds may be known but there's still risk of default (counterparty risk), 
and the rate-of-return on equity investments is fundamentally unknown, since that depends on future stock prices. 

To determine the future value of present investments in equity and bonds, you must choose an appropriate 
rate-of-return on those investments.  The higher the rate-of-return, the higher the future value.  The lower the rate-of-return,
the lower the future value.  

* The Stanford study chose a lower rate-of-return (4%), and determined that the future value of the fund's assets covered 
only 50% of the fund's future liabilities (the fixed pension payments).  
* CalPERS responded by choosing a higher rate-of-return (7.5%), giving a higher future value that covered 86% of future liabilities.


Note that "rate-of-return" and "discount rate" refer to the same thing, only from different points of view:

* When determining the future value of an investment made today, you think of the interest rate as the "rate-of-return" --
i.e. the return on on today's investment.  
* When determing the present value of some future cash flow, you think of the interest rate as the "discount rate" --
i.e. the amount to discount the future value.


<br />
### Valuing a stream of CERTAIN (risk-free) returns vs. UNCERTAIN (risky) returns

Imagine two scenarios:

1. Google has an expected growth rate of 20%, but it's uncertain
2. Google has an expected growth rate of 20%, and it's absolutely certain

What happens to Google's stock price when going from #1 to #2?

The stock price would go UP because the discount rate would go DOWN.
The discount rate, in part, reflects uncertainty in the returns.  If there's NO uncertainty
in the returns, then a lower discount rate is applied (like the risk-free rate).
The BETA (systemic risk) is 0 (equal to the risk-free rate), since returns are guaranteed,
regardless of the wider market performance.  

Should we value a stream of liabilities the same way we value a stream of profits/returns?
Probably yes, if the stream of liabilities is known and fixed (as they are for defined-benefit plans).


<br />
### Valuing a future FIXED liability

Imagine you need $100K in 5 years.  Imagine it's an absolutely fixed future liability.

Your bank offers a 5-year CD that returns 2% per year.  This is low-risk, practically guaranteed return.
At this discount rate, the present value of $100K 5 years from now is:

$$
\begin{align*}
PV &= \frac{FV}{(1+r)^t}
\\\\
PV &= \frac{100K}{(1+0.02)^5}
\end{align*}
$$


```r
pv <- 100 / (1+0.02)^5
pv
```

```
## [1] 90.57308
```

The present value of a $100K future liability, at a discount rate of 2%, is $90,573.  So you'd need
to invest $90K into the 5-year CD to be guaranteed $100K in 5 years.

But, you notice that US stocks historically return 12% on average.  At this discount rate, the 
present value of $100K in 5 years is:


```r
pv  <- 100 / (1+0.12)^5
pv
```

```
## [1] 56.74269
```

The present value of a $100K future liability, at a discount rate of 12%, is $56,743. So you
need only invest $56,743 in the stock market today to get $100K in 5 years.

However, this is an UNCERTAIN return.  There's no guarantee that in 5 years you'll actually
have $100K to meet your fixed liability.  Therefore this is probably NOT the appropriate discount
rate to use when valuing that future liability. 

If you know your future liability is FIXED, and you want to guarantee that you'll have the
funds to meet it, then you should use a risk-free discount rate, and invest in risk-free assets.


<br />
### Valuing a stream of FIXED returns vs. VARIABLE returns

Imagine two defined-benefit pension plans:

1. Pays 4% fixed
2. Pays 1/3 market (avg market perf: 12%)

When going from plan 1 to 2, what happens to the value of the plan, both from the participants'
perspective and from the employer's perspective?

#1. FIXED payments are not dependent on market performance.  Whether the market is up or down, the
payments have to be made.  This influences the types of assets you need to invest in to guarantee
that you can meet your FIXED future liabilities.  You need relatively risk-free assets, to ensure
you can meet liabilities even when the market is down.  This implies a lower discount rate.
A lower discount rate means a higher present value.

From the employer's perspective, a higher present value represents a higher cost.

From the participants' point of view, a higher present value is just that: a higher value. Another
reason FIXED payments are more valuable to the participants is that they act as a hedge against
the market.  If the market is doing well, then chances are the participants are benefiting from
other investments.  If the market is doing poorly, a fixed payment provides a guaranteed cash flow.

So a FIXED payment plan is costlier to employers, more valuable to participants.


#2. Variable payments are dependent on market performance.  The payment varies, depending on
whether the market is up or down.  This means the fund can invest in riskier assets, e.g. a
market index fund.  The discount rate is therefore higher than for a FIXED plan.  Which means
the present value is lower than for a FIXED plan.  

From the employer's perspective, a lower present value represents a lower cost.

From the participants' perspective, the plan is less valuable than a FIXED plan.  For one,
the present value is lower.  For two, a variable payment doesn't hedge the market.  So when
the participants other investments are going down, so is their pension payment.  In theory
the payment could even go to zero.


**Wisconsin** is an example of a state that's moving from a FIXED to VARIABLE public pension plan.



<br />
### Insuring pension plans (PBGC)

**PBGC:**  Pension Benefit Guaranty Corp, provides insurance to workers with defined-benefit
pension plans, in the event the firm that owns the pension plan goes bankrupt.

PBGC collects premiums from firms. It takes over the pension plan if the firm fails.  

How should PBGC invest its assets (the premiums)?   
E.g. what fraction in fixed-income and what fraction in equities?  

**BEWARE of INVERTED BALANCE SHEETS!!**  "Inverted" is basically the opposite of "hedged".

* **Hedged** - assets and liabilities move together (positively correlated).  When liabilities go up, so do assets, so the
fund remains solvent.  When assets go down, so do liabilities, so again, the fund is solvent.
* **Inverted** - assets and liabilities move in OPPOSITE directions (negative correlated).  When assets go up, liabilities
go down, and everything's great!  HOWEVER, when assets go down, liabilities go up, exacerbating the 
fund's financial distress.  

PBGC should NOT invest much in equities.  Why?  Because when equities are dropping due to market
failure, chances are that bankruptcies are going up, which means PBGC's liabilities are also going up,
just as its assets are going down.

In 2008, PBGC switch from 20% equities to 50% equities, to try to improve fund performance in order
to meet liabilities. This is unlikely to end well.  Think late 90's Brazil.  Think China today.  Think Michael Pettis.



<br />
### Conclusion

Key question #1. which discount rate to use to convert future costs into present value today?  
  
FIXED future liabilities require a low-risk investment strategy today.  The discount rate
of the future cash flows should be low, reflecting the low-risk nature of the investments that
must be made today in order to guarantee that future liabilities are met, regardless of 
market performance.

Key question #2. does the asset investment strategy (e.g. higher vs lower risk) influence the value of the pension's liabilities?  
  
Taking on riskier assets does NOT shrink the present value of FIXED future liabilities. 
FIXED liabilities are CERTAIN liabilities and therefore require a CERTAIN (risk-free) rate-of-return/discount rate.
Therefore the appropriate discount rate is the RISK-FREE discount rate, which is CERTAIN (well, as certain
as you can get).

Also: **BEWARE INVERTED BALANCE SHEETS!**  Especially if you're an insurance company.  Or a nation state.





