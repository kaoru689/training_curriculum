class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    getWeek
    @plan = Plan.new
  end

  # 予定の保存
  def create
    Plan.create(plan_params)
    redirect_to action: :index
  end

  private

  def plan_params
    params.require(:plan).permit(:date, :plan)
  end

  def getWeek

    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

    # Dateオブジェクトは、日付を保持しています。下記のように`.today.day`とすると、今日の日付を取得できます。
    @todays_date = Date.today
    # 例)　今日が2月1日の場合・・・ Date.today.day => 1日


    @week_days = []

    @plans = Plan.where(date: @todays_date..@todays_date + 7)

    7.times do |x|
      plans = []
      plan = @plans.map do |plan|
        plans.push(plan.plan) if plan.date == @todays_date + x
      end
      days = { :month => (@todays_date + x).month, :date => (@todays_date+x).day, :plans => plans, :wday => wdays[(@todays_date+x).wday] }
      @week_days.push(days)
    end

  end
end

# x = 0
# plans = []
#       plan = @plans.map do |plan|
#         plans.push(plan.plan) if plan.date == @todays_date
#       end
#       days = { :month => (@todays_date).month, :date => (@todays_date).day, :plans => plans, :wday => wdays[(@todays_date).wday] }
#       @week_days.push(days)

# x = 1
# plans = []
#       plan = @plans.map do |plan|
#         plans.push(plan.plan) if plan.date == @todays_date + 1
#       end
#       days = { :month => (@todays_date + 1).month, :date => (@todays_date + 1).day, :plans => plans, :wday => wdays[(@todays_date + 1).wday] }
#       @week_days.push(days)
