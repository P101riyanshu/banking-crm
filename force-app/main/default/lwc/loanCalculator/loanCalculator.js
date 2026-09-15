import { LightningElement } from 'lwc';

export default class LoanCalculator extends LightningElement {

    loanAmount = 500000;
    interestRate = 10;
    tenure = 60;

    emi = 0;
    totalInterest = 0;
    totalPayable = 0;

    connectedCallback() {
        this.calculate();
    }

    handleChange(event) {

        const field = event.target.name;

        this[field] = Number(event.target.value);

        this.calculate();
    }

    calculate() {

        const principal = Number(this.loanAmount);
        const annualRate = Number(this.interestRate);
        const months = Number(this.tenure);

        if (
            principal <= 0 ||
            annualRate < 0 ||
            months <= 0
        ) {

            this.emi = 0;
            this.totalInterest = 0;
            this.totalPayable = 0;

            return;
        }

        const monthlyRate =
            annualRate / 12 / 100;

        // Zero-interest loan
        if (monthlyRate === 0) {

            this.emi = principal / months;

        } else {

            this.emi =
                principal *
                monthlyRate *
                Math.pow(
                    1 + monthlyRate,
                    months
                ) /
                (
                    Math.pow(
                        1 + monthlyRate,
                        months
                    ) - 1
                );
        }

        this.totalPayable =
            this.emi * months;

        this.totalInterest =
            this.totalPayable - principal;
    }

    get formattedEmi() {

        return this.formatCurrency(this.emi);
    }

    get formattedInterest() {

        return this.formatCurrency(
            this.totalInterest
        );
    }

    get formattedPayable() {

        return this.formatCurrency(
            this.totalPayable
        );
    }

    formatCurrency(value) {

        return new Intl.NumberFormat(
            'en-IN',
            {
                style: 'currency',
                currency: 'INR',
                maximumFractionDigits: 2
            }
        ).format(value || 0);
    }
}