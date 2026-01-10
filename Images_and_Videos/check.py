import os
import glob

def check_webm_optimization(filename):
    # EBML IDs
    CUES_ID = b'\x1c\x53\xbb\x6b'      # The Index
    CLUSTER_ID = b'\x1f\x43\xb6\x75'   # The Video Data

    try:
        with open(filename, 'rb') as f:
            # Read first 500KB to be safe (sometimes headers are large)
            header_data = f.read(500 * 1024) 

            cues_pos = header_data.find(CUES_ID)
            cluster_pos = header_data.find(CLUSTER_ID)

            print(f"Checking: {filename}...", end=" ")
            
            if cues_pos == -1:
                print("❌ [FAIL] Index NOT found in header (It is likely at the end).")
                return False
            
            if cluster_pos == -1:
                print("❓ [WARN] No Video Data found in header.")
                return False

            if cues_pos < cluster_pos:
                print("✅ [SUCCESS] Optimized!")
                return True
            else:
                print("❌ [FAIL] Not Optimized (Index is after Video).")
                return False
    except Exception as e:
        print(f"❌ [ERROR] Could not read file: {e}")
        return False

def check_all():
    print("--- Verifying All WebM Files ---")
    # Find all .webm files recursively
    webm_files = glob.glob("**/*.webm", recursive=True)
    
    if not webm_files:
        print("No WebM files found!")
        return

    passed = 0
    failed = 0

    for f in webm_files:
        if check_webm_optimization(f):
            passed += 1
        else:
            failed += 1

    print("\n--- SUMMARY ---")
    print(f"Optimized: {passed}")
    print(f"Failed:    {failed}")
    
    if failed > 0:
        print("\n⚠️  Run 'python3 finish_fixing.py' again to fix the failed files.")
    else:
        print("\n🎉 All files are ready for streaming!")

if __name__ == "__main__":
    check_all()