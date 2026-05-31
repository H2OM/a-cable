import OrderSuccess from "@components/order/client/OrderSuccess";

export default async function Page({params}: {
    params: Promise<{ id: string }>;
}) {
    const parseParams = await params;

    return <OrderSuccess id={Number(parseParams.id)}/>
}