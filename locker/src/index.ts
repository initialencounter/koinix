import Scanner from '@koishijs/registry'
import axios from 'axios'
import { promises as fsp } from 'fs'

// TODO: fetch registry.koishi.chat?
;(async () => {
  const scanner = new Scanner(async url => {
    const { data } = await axios.get('https://registry.npmjs.com' + url)
    return data
  })
  await scanner.collect()
  const packages = await scanner.analyze({ version: '4' })
  const pj = {
    name: 'lock',
    version: '0.0.0',
    dependencies: packages.reduce((acc, [latest]) => {
      acc[latest.name] = `^${latest.version}`
      return acc
    }, { koishi: '*' }),
  }
  await fsp.mkdir('./lock', { recursive: true })
  await fsp.writeFile('./lock/package.json', JSON.stringify(pj))
})()