let values = {
  pressure: 0,
  of: 0,
  cstar: 0,
};

let lines: string[] = [];
const emit = () => {
  lines.push(`${values.pressure} ${values.of} ${values.cstar}`);
};
for (const line of require("fs")
  .readFileSync("./cea.txt", "utf-8")
  .split("\n")) {
  if (line.startsWith(" P, BAR")) {
    const [, arg] = line.split(/\s{2,}/);
    values.pressure = parseFloat(arg);
  }
  if (line.startsWith(" CSTAR, M/SEC")) {
    const [, arg] = line.split(/\s{2,}/);
    values.cstar = parseFloat(arg);
  }
  if (line.startsWith(" O/F=")) {
    const [, arg] = line.split(/\s{2,}/);
    values.of = parseFloat(arg);
  }
  if (line.startsWith(" NOTE. ")) {
    const [, arg] = line.split(/\s{2,}/);
    emit();
  }
}

lines.unshift("cstarTable = [");
lines.push("];");
require("fs").writeFileSync(
  "./combustion/properties/cstarInterpolationTable.m",
  lines.join("\n")
);
