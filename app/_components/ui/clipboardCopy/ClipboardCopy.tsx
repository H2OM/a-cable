'use client';

import './clipboard-copy.scss';
import {Icons} from "@ui/icons/Icons";
import toast from "react-hot-toast";
import {ReactNode} from "react";

export default function ClipboardCopy({children, content}: {children?: ReactNode, content: string}) {
    const handleCopy = async () => {
        const PERMISSION_STATUS = await navigator.permissions.query({
            name: 'clipboard-write' as PermissionName
        });

        if (PERMISSION_STATUS.state === 'denied') {
            alert('Доступ к буферу обмена запрещен в настройках браузера.');
            return;
        }

        if (navigator.clipboard) void navigator.clipboard.writeText(content);

        toast.success('Артикул скопирован');
    }

    return (
        <span className="clipboard-copy" onClick={handleCopy}>
            <span>{children ?? content}</span>
            <Icons type={'copy'}/>
        </span>
    )
}