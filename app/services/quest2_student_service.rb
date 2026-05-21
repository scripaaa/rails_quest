class Quest2StudentService
  class << self
    # @return [String]
    def all_agents
      Agent.pluck(:codename).join("\n")
    end

    # @return [String]
    def all_missions
      Mission.order(:title).pluck(:title).join("\n")
    end

    # @return [String]
    def agents_with_missions
      Agent.order(:codename).map do |agent|
        missions = agent.missions.order(:title).pluck(:title).join(", ")
        "#{agent.codename}: #{missions}"
      end.join("\n")
    end

    # @return [String]
    def agents_with_missions_sorted_by_mission_count
      Agent
        .left_joins(:missions)
        .group(:id)
        .order(Arel.sql("COUNT(missions.id) DESC"), :codename)
        .map do |agent|

        missions = agent.missions.order(:title).pluck(:title).join(", ")

        "#{agent.codename} (#{agent.missions.count}): #{missions}"
      end.join("\n")
    end

    # @return [String]
    def agents_with_skills
      Agent.order(:codename).map do |agent|
        skills = agent.skills.order(:name).pluck(:name).join(", ")
        "#{agent.codename}: #{skills}"
      end.join("\n")
    end

    # @return [String]
    def skills_by_agent_count
      Skill
        .left_joins(:agents)
        .group(:id)
        .order(Arel.sql("COUNT(agents.id) DESC"), :name)
        .map do |skill|

        agents = skill.agents.order(:codename).pluck(:codename).join(", ")

        "#{skill.name} (#{skill.agents.count}): #{agents}"
      end.join("\n")
    end
  end
end