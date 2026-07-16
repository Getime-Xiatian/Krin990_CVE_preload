#!/bin/bash
#
# Extract struct offsets from vmlinux with pahole
# Usage: ./pahole_extract.sh [path/to/vmlinux]
# Default: ./out/vmlinux

VMLINUX="${1:-out/vmlinux}"

if [ ! -f "$VMLINUX" ]; then
    echo "Error: $VMLINUX not found"
    echo "Usage: $0 [path/to/vmlinux]"
    exit 1
fi

echo "=============================================="
echo "  STRUCT OFFSETS from $VMLINUX"
echo "=============================================="
echo ""

echo "=== rt_mutex_waiter ==="
pahole -C rt_mutex_waiter "$VMLINUX"
echo ""

echo "=== task_struct (key fields) ==="
pahole -C task_struct "$VMLINUX" | grep -E "pid_t\s+pid|pid_t\s+tgid|real_cred|\bcred\b|seccomp|tasks\b|pi_blocked_on|pi_waiters|atomic_flags|real_parent|thread_pid|pi_lock|comm\["
echo ""

echo "=== cred ==="
pahole -C cred "$VMLINUX" | grep -E "usage|uid\b|gid\b|securebits|cap_inheritable|security|euid|suid|fsuid"
echo ""

echo "=== pipe_inode_info ==="
pahole -C pipe_inode_info "$VMLINUX"
echo ""

echo "=== file_operations (first 14 members) ==="
pahole -C file_operations "$VMLINUX" | head -16
echo ""

echo "=== configfs_bin_file_operations ==="
pahole -C configfs_bin_file_operations "$VMLINUX"
echo ""

echo "=== miscdevice ==="
pahole -C miscdevice "$VMLINUX"
echo ""

echo "=== seccomp ==="
pahole -C seccomp "$VMLINUX"
echo ""

echo "=== selinux_state ==="
pahole -C selinux_state "$VMLINUX"
echo ""

echo "=== page (first 8 members) ==="
pahole -C page "$VMLINUX" | head -10
echo ""
