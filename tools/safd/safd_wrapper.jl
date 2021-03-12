println("Importing Dependencies")
using MS_Import
using SAFD
import CSV

function main(args)
    output_filename = "peaks"
    max_iterations=10
    max_peak_width_rt=20
    resolution=20000
    min_spectrum_width_mz=0.02
    rt_threshold=0.85
    min_intensity=2000
    sigma_increase_threshold=5
    signal_to_noise=2
    min_peak_width_scans=3
    filename = args[1]
    output_dest = args[2]

    println("Creating symlink for '$filename'")
    symlink_name = string(filename,".mzXML")
    Base.Filesystem.symlink(filename, symlink_name)

    chromatogram = import_files("", [ symlink_name ], [0,0])


    rep_table,final_table=safd(
        chromatogram["MS1"]["Mz_values"],
        chromatogram["MS1"]["Mz_intensity"],
        chromatogram["MS1"]["Rt"],
        filename,
        pwd(),
        max_iterations,
        max_peak_width_rt,
        resolution,
        min_spectrum_width_mz,
        rt_threshold,
        min_intensity,
        sigma_increase_threshold,
        signal_to_noise,
        min_peak_width_scans)

        CSV.write(output_dest, final_table)
end

main(ARGS)