#= require rendering

ApplicationHelpers =
  legalityClass: (legality) -> legality.toLowerCase()

Rendering.helpers.app = ApplicationHelpers
