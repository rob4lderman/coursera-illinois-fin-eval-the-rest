

## Microsoft MSFT firm valuation

### Rough approximations

* "Operating Income" is a close approx of EBIT
* Effective corp tax rate approx 20-25% (not the 35% federal statutory rate)


### Firm valuation questions

What's an appropriate discount rate?
What's an appropriate growth rate?
Is growth steady-state (can we value like a perpetuity)?
Or should we forecast growth in the near term?

What's the firm's capital structure look like?
Debt / Equity ratio?
If debt is low, then WACC will essentially be the required return on the firm's equity.
Total firm value will be value of firm's stock (low debt obligations).


### Data

Get data from:

sec's website.

morningstar.com
    - accounting data for last 5 years

finance.yahoo.com
    - accounting data for last 3 years


### Assignment questions

1. What's a reasonable required return for the firm (WACC) going forward?  Why?
2. What is the free cash flow (FCF) of the firm in the most recent year?
3. Is the firm in equilibrium (in terms of growth)? If so, what's your long term
assumption for the growth rate?  If not, why not?
4. Estimate the firm's equity value based on discount rate, FCF, and growth rate.
Compare with the firm's actual equity value.



### Firm Valuation via Discounted Cash Flow (Free Cash Flow) method

There are (at least) two ways to value a firm:

1. **Market multiples**: use the valuation ratios (e.g. P/E) of a comparable firm 
2. **Discounted Cash Flows**: determine the firm's future cash flows, then discount those cash flows back to present value

We're going to use #2, Discounted Cash Flows.  Within the Discounted Cash Flows method, there are (at least)
three ways to measure cash flow:

1. Capital cash flow - cash flow available to both equity and debt holders, debt interest deduction adjusted for in cash flow
2. Equity cash flow - cash flow available to equity holders, after debt payments deducted
3. Free cash flow - cash flow available to both equity and debt holders, debt interest deduction adjusted for in discount rate (WACC)

We'll use #3, the "free cash flow".  The firm valuation equation is:

$$
V_F = PV[FCF_T] + PV[TV_T] + NOA
$$

<ul>
<li> \(V_F\) is the value of the firm </li>
<li> \(PV[FCF_T]\) is the present value of the firm's free cash flow up to period T </li>
<li> \(PV[TV_T]\) is the present value of the firm's "terminal value" -- all future cash flows after period T (perpetuity formula)</li>
<li> NOA is the market value of any "non-operating assets" -- stuff the firm owns but isn't really using (e.g. land)</li>
</ul>

The total value of the firm is divided up between all claimants -- i.e. all debt holders and all equity holders.

$$
V_F = V_debt + V_equity
$$

<ul>
<li> \(V_debt\) is the market value of the firm's DEBT </li>
<li> \(V_equity\) is the market value of the firm's EQUITY </li>
</ul>

In order to calculate the present value of future cash flows, we need to determine a suitable discount rate.  The discount
rate usually applied to the free cash flow method is the **weighted average cost of capital (WACC)**.  The WACC is the
weighted average of the required returns on the securities used to finance the firm's assets.  In other words, the firm
has issued some mix of equity and debt in order to finance its assets (its "cost of capital").  The required return on the 
firm (the discount rate) is equal to the required return(s) on that debt and equity, weighted according to the relative
proportions of debt and equity.  This is the "weighted average cost of capital".

The WACC (discount rate) formula:

$$
WACC = (1 + t_corp)(r_debt \cdot \frac{debt}{V_F}) + (r_equity + \frac{equity}{V_F})
$$

<ul>
<li> \(t_corp\) is the corporate tax rate on earnings </li>
<li> \(r_debt\) is the corporate tax rate on earnings </li>
</ul>



