# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :nickname,           null: false, default: "", uniqueness: {case_sensitive: false}
      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      
      ### 아이템 관련
      t.integer :item_freehint, default: 0
      t.integer :item_2018likelion, default: 0
      
      ### 랭킹 관련
      t.float :rank_point, default: 0
      
      
      ### 칭호 관련
      t.string :applying_award, default: ""
      
      t.integer :award_try, default: 0         #정답시도횟수
      t.integer :award_fail, default: 0        #정답실패횟수
      t.integer :award_clear, default: 0       #방탈출클리어횟수
      t.integer :award_make, default: 0        #방탈출제작횟수
      t.integer :award_edit, default: 0        #방탈출수정횟수
      t.integer :award_distribute, default: 0  #방탈출배포횟수
      t.integer :award_delete, default: 0      #방탈출삭제횟수
      t.integer :award_single, default: 0      #싱글플레이횟수
      t.integer :award_multi, default: 0       #멀티플레이횟수
      
      
      t.integer :awardtitle_A1, default: 0     #[탈출] - 탈출을 시도한 자 (정답 제출 시도 10회 달성 시 획득)
      t.integer :awardtitle_A2, default: 0     #[탈출] - 탈출에 숙련된 자 (정답 제출 시도 50회 달성 시 획득)
      t.integer :awardtitle_A3, default: 0     #[탈출] - 탈출을 깨우친 자 (정답 제출 시도 100회 달성 시 획득)
      t.integer :awardtitle_A4, default: 0     #[탈출] - 탈출의 귀재 (정답 제출 시도 200회 달성 시 획득)
      
      t.integer :awardtitle_B1, default: 0     #[실패] - 실패를 경험한 자 (오답 10회 달성 시 획득)
      t.integer :awardtitle_B2, default: 0     #[실패] - 실패에 익숙한 자 (오답 50회 달성 시 획득)
      t.integer :awardtitle_B3, default: 0     #[실패] - 실패를 두려워하지 않는 자 (오답 100회 달성 시 획득)
      t.integer :awardtitle_B4, default: 0     #[실패] - 실패를 극복해낸 자 (오답 200회 달성 시 획득)
      
      t.integer :awardtitle_C1, default: 0     #[성공] - C급 방탈출러 (클리어 방탈출 갯수 1개 달성 시 획득)
      t.integer :awardtitle_C2, default: 0     #[성공] - B급 방탈출러 (클리어 방탈출 갯수 10개 달성 시 획득)
      t.integer :awardtitle_C3, default: 0     #[성공] - A급 방탈출러 (클리어 방탈출 갯수 25개 달성 시 획득)
      t.integer :awardtitle_C4, default: 0     #[성공] - S급 방탈출러 (클리어 방탈출 갯수 50개 달성 시 획득)
      t.integer :awardtitle_C5, default: 0     #[성공] - SS급 방탈출러 (클리어 방탈출 갯수 100개 달성 시 획득)
      
      t.integer :awardtitle_D1, default: 0     #[메이킹] - 방탈출 메이커 : 기본 (제작 스테이지 갯수 10개 시 획득)
      t.integer :awardtitle_D2, default: 0     #[메이킹] - 방탈출 메이커 : 숙련 (제작 스테이지 갯수 25개 시 획득)
      t.integer :awardtitle_D3, default: 0     #[메이킹] - 방탈출 메이커 : 완성 (제작 스테이지 갯수 50개 시 획득)
      t.integer :awardtitle_D4, default: 0     #[메이킹] - 전설의 메이커 (제작 스테이지 갯수 100개 시 획득)
      
      t.integer :awardtitle_E1, default: 0     #[편집] - 수정의 장인 (방탈출 수정 횟수 20회 달성 시 획득)
      t.integer :awardtitle_E2, default: 0     #[편집] - 수정의 명인 (방탈출 수정 횟수 100회 달성 시 획득)
      t.integer :awardtitle_E3, default: 0     #[편집] - 수정의 달인 (방탈출 수정 횟수 200회 달성 시 획득)
      t.integer :awardtitle_E4, default: 0     #[편집] - 배포의 장인 (방탈출 배포 횟수 10회 달성 시 획득)
      t.integer :awardtitle_E5, default: 0     #[편집] - 배포의 명인 (방탈출 배포 횟수 50회 달성 시 획득)
      t.integer :awardtitle_E6, default: 0     #[편집] - 배포의 달인 (방탈출 배포 횟수 100회 달성 시 획득)
      t.integer :awardtitle_E7, default: 0     #[편집] - 삭제의 장인 (방탈출 삭제 횟수 10회 달성 시 획득)
      t.integer :awardtitle_E8, default: 0     #[편집] - 삭제의 명인 (방탈출 삭제 횟수 50회 달성 시 획득)
      t.integer :awardtitle_E9, default: 0     #[편집] - 삭제의 달인 (방탈출 삭제 횟수 100회 달성 시 획득)
      
      t.integer :awardtitle_F1, default: 0     #[싱글플레이] - 홀로서 시작한 자 (싱글플레이 시작횟수 1회 달성 시 획득)
      t.integer :awardtitle_F2, default: 0     #[싱글플레이] - 홀로서 탈출한 자 (싱글플레이 시작횟수 10회 달성 시 획득)
      t.integer :awardtitle_F3, default: 0     #[싱글플레이] - 홀로서도 탈출의 고수 (싱글플레이 시작횟수 25회 달성 시 획득)
      t.integer :awardtitle_F4, default: 0     #[싱글플레이] - 홀로 탈출의 귀인 (싱글플레이 시작횟수 50회 달성 시 획득)
      
      t.integer :awardtitle_G1, default: 0     #[멀티플레이] - 함께 시작한 자 (멀티플레이 시작횟수 1회 달성 시 획득)
      t.integer :awardtitle_G2, default: 0     #[멀티플레이] - 함께 탈출한 자 (멀티플레이 시작횟수 10회 달성 시 획득)
      t.integer :awardtitle_G3, default: 0     #[멀티플레이] - 함께라면 두렵지 않아 (멀티플레이 시작횟수 25회 달성 시 획득)
      t.integer :awardtitle_G4, default: 0     #[멀티플레이] - 함께 탈출의 귀인 (멀티플레이 시작횟수 50회 달성 시 획득)
      
      t.integer :awardtitle_H1, default: 0     #[기타] - 레전드 레이서 (정답 시도 횟수 10000회 달성 시 획득)
      t.integer :awardtitle_H2, default: 0     #[기타] - 레전드 이스케이퍼 (방탈출 클리어 횟수 1000회 달성 시 획득)
      
      #S0_6 칭호 미구현
      t.integer :awardtitle_S0_1, default: 0   #[랭킹(시즌0)] - 프리시즌 방탈출 참가자 (프리시즌 기간동안 한번이라도 방탈출 클리어 시 획득)
      t.integer :awardtitle_S0_2, default: 0   #[랭킹(시즌0)] - 프리시즌 방탈출 트라이어 (프리시즌 기간동안 숙련자 등급에 도달하면 획득)
      t.integer :awardtitle_S0_3, default: 0   #[랭킹(시즌0)] - 프리시즌 방탈출 챌린저 (프리시즌 기간동안 실력자 등급에 도달하면 획득)
      t.integer :awardtitle_S0_4, default: 0   #[랭킹(시즌0)] - 프리시즌 방탈출 랭커 (프리시즌 기간동안 마스터 등급에 도달하면 획득)
      t.integer :awardtitle_S0_5, default: 0   #[랭킹(시즌0)] - 프리시즌 방탈출 그랜드랭커 (프리시즌 기간동안 그랜드마스터 등급에 도달하면 획득)
      t.integer :awardtitle_S0_6, default: 0   #[랭킹(시즌0)] - 프리시즌 방탈출 챔피언 (프리시즌 기간동안 첫번째로 그랜드마스터 등급에 도달하면 획득)
      
      t.integer :awardtitle_Z1, default: 0     #[스폐셜] - 멋쟁이처럼 탈출하기 (2018 멋쟁이 사자처럼 해커톤에 참가자들을 위한 특별 칭호)
      
      
      
      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
