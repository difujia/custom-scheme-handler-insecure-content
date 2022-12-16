async function main() {
    const res = await fetch("custom-scheme://image.data");
    console.log(`Fetched data length: ${res.arrayBuffer.length}`);
}

main();
