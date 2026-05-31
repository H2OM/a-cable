'use client';

import './spinner.scss';

export default function Spinner({className = '', mini = false, color = false}: {
    className?: string;
    mini?: boolean;
    color?: boolean;
}) {
    return (
        <div
            className={
                (mini ? 'spinner-mini' : 'spinner') +
                (className ? ` ${className}` : '') +
                (color ? ' _color' : '')
            }
        ></div>
    );
}