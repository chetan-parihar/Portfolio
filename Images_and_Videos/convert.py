import os
import subprocess
import glob

def finish_job():
    # Find ALL WebM files (recursive)
    print("--- Retrying Failed Files ---")
    webm_files = glob.glob("**/*.webm", recursive=True)
    
    success = 0
    fail = 0

    for filename in webm_files:
        # Check if file exists to avoid path errors
        if not os.path.isfile(filename):
            continue

        temp_name = f"{filename}.temp.webm"
        
        # We run the fix on EVERY file again just to be safe.
        # -n means "do not overwrite" (we manually move later if successful)
        cmd = [
            "ffmpeg", "-y", "-v", "error", "-i", filename,
            "-c", "copy",
            "-reserve_index_space", "100k", 
            temp_name
        ]
        
        try:
            subprocess.run(cmd, check=True)
            os.replace(temp_name, filename)
            print(f"  [OK] Fixed: {filename}")
            success += 1
        except:
            print(f"  [ERROR] Still failing: {filename}")
            fail += 1
            if os.path.exists(temp_name): os.remove(temp_name)

    print(f"\n--- SUMMARY ---")
    print(f"Total Fixed: {success}")
    print(f"Failed:      {fail}")

if __name__ == "__main__":
    finish_job()
