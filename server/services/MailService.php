<?php

namespace app\services;

use app\core\Env;
use Symfony\Component\Mailer\Exception\TransportExceptionInterface;
use Symfony\Component\Mailer\Mailer;
use Symfony\Component\Mailer\Transport;
use Symfony\Component\Mime\Email;

/** Сервис для отправки писем */
readonly class MailService {
    private const string LAYOUTS_PATH = __DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'layouts' . DIRECTORY_SEPARATOR;
    private Mailer $mailer;

    public function __construct(
        private Env $env
    ) {
        $transport = Transport::fromDsn(
            sprintf(
                'smtp://%s:%s@%s:%s',
                $env->get('MAIL_USER'),
                $env->get('MAIL_PASSWORD'),
                $env->get('MAIL_HOST'),
                $env->get('MAIL_PORT')
            )
        );

        $this->mailer = new Mailer($transport);
    }

    /**
     * Отправка письма
     *
     * @param string $to
     * @param string $subject
     * @param string $html
     * @return void
     * @throws TransportExceptionInterface
     */
    public function send(
        string $to,
        string $subject,
        string $html
    ): void {
        $email = (new Email())
            ->from($this->env->get('BASE_EMAIL'))
            ->to($to)
            ->subject($subject)
            ->html($html);

        $this->mailer->send($email);
    }

    /**
     * Получение базовой структуры письма для заказа
     * >**Обязательные поля:**
     *
     *     [
     *         'main_info' => ['field_name' => 'field_value'],
     *         'order_url' => string,
     *         'site_url' => string,
     *         'products' => [
     *               ['image_url' => string, 'price' => string|int 'title' => string, 'count' => int]
     *          ]
     *      ]
     *
     *  >**НЕ обязательные поля:**
     *
     *      [
     *          'user' => [
     *              'first_name' => string,
     *              'second_name' => string,
     *              'temp_password' => string,
     *              'personal_url' => string
     *          ]
     *      ]
     * @param array $data
     * @return string
     */
    public function getBaseHtmlOrder(array $data): string {
        return $this->getBaseHtml(template: 'order', data: $data);
    }

    /**
     * Получение базовой структуры письма
     *
     * @param string $template
     * @param array $data
     * @return string
     */
    private function getBaseHtml(string $template, array $data): string {
        extract($data);
        ob_start();

        require self::LAYOUTS_PATH . "$template.php";

        return ob_get_clean();
    }
}