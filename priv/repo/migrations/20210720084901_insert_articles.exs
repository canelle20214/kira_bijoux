defmodule KiraBijoux.Repo.Migrations.InsertArticles do
  use KiraBijouxWeb, :migration

  def change do
    Repo.insert_all(Article,
    [
    %{name: "", page_id: 2, content: "Adepte du DIY depuis toujours, ce terme n’existait pas encore en France quand ma mère m’apprenait à construire mes bijoux, entre autres, en 1995, à l’aide de perles, de fil de pêche et de coquillages ramassés sur la plage ! Le « Do It Yourself » se prononçait à l’époque « Si tu ne peux pas acheter, construis-le toi-même ! En plus, c’est beaucoup plus marrant ! ». A l’âge de 12 ans, je trouvais une vieille pelote de laine et des aiguilles dans un placard de la maison de campagne. Il est donc temps pour ma mère de m’apprendre à tricoter, après m’avoir appris à coudre !
    Mais ce n’est que bien plus tard que je décide de lancer mon auto-entreprise afin de proposer à la vente mes créations. Il est donc évident pour moi de créer une alliance entre bijoux et tricot.
    Au plus proche de la nature depuis ma tendre enfance, je suis attirée depuis toujours par les matières naturelles. C’est donc tout naturellement que j’ai souhaité élaborer des modèles de bijoux à partir de pierres fines (ou « semi-précieuses »).
    Soyez-en sûrs, toutes mes créations sont réalisées avec patience et amour, dans mon atelier en Essonne.
    Je produis peu car je travaille seule sur les créations de Kira. Vous pouvez donc être sûrs de ne pas voir beaucoup de personnes porter le même bijou que vous !
    ", place: 1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
    %{name: "Chez Kira, la politique de retour dure 30 jours.", page_id: 3, content: "Si vous n'êtes pas satisfait de votre achat, vous avez 30 jours à compter de la réception de votre commande pour retourner votre produit. Si 30 jours se sont écoulés depuis votre achat, nous ne pouvons malheureusement pas vous offrir un remboursement ou un échange.

    Pour pouvoir bénéficier d'un retour, votre article doit être inutilisé et dans le même état où vous l'avez reçu. Il doit être également dans l'emballage d'origine.

    Certains types de produits ne peuvent pas être retournés, tels que les cartes cadeaux ou les articles soldés. Pour effectuer un retour, vous devez nous présenter un reçu ou une preuve d'achat.", place: 1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
    %{name: "- REMBOURSEMENTS -", page_id: 3, content: "Une fois que nous aurons reçu et inspecté l'article retourné, nous vous enverrons un e-mail pour vous confirmer que nous l'avons bien reçu. Nous vous informerons également de notre décision quant à l'approbation ou au rejet de votre demande de remboursement.

    Si votre demande est approuvée, alors votre remboursement sera traité, et un crédit sera automatiquement appliqué à votre carte de crédit ou à votre méthode originale de paiement, dans un délai d'un certain nombre de jours.", place: 2, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
    %{name: "- REMBOURSEMENTS EN RETARD OU MANQUANTS -", page_id: 3, content: "Si vous n'avez pas encore reçu votre remboursement, veuillez d'abord consulter votre compte bancaire à nouveau. Ensuite, contactez l'entité émettrice de votre carte de crédit, car il pourrait y avoir un délai avant que votre remboursement ne soit officiellement affiché. Ensuite, contactez votre banque. Il y a souvent un délai de traitement nécessaire avant qu'un remboursement ne soit affiché.

    Si après avoir effectué toutes ces étapes, vous n'avez toujours pas reçu votre remboursement, veuillez s'il vous plait nous contacter via l'adresse mail contact@kira-bijoux.com.", place: 3, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
    %{name: "- ARTICLES SOLDÉS -", page_id: 3, content: "Seuls les articles à prix courant peuvent être remboursés. Malheureusement, les articles soldés ne sont pas remboursables.", place: 4, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
    %{name: "- ÉCHANGES -", page_id: 3, content: "Nous remplaçons un article seulement s'il est défectueux ou endommagé, sans jamais avoir été porté ou utilisé. Si dans ce cas vous souhaitez l'échanger contre le même article, envoyez-nous un e-mail à contact@kira-bijoux.com et envoyez-nous votre article à :
    Kira, 146 route de Corbeil, Bât.5 - Apt 3007, 91180, St-Germain-lès-Arpajon, France.", place: 5, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
    %{name: "- CADEAUX -", page_id: 3, content: "Si l'article retourné était identifié comme un cadeau lors de l'achat et s'il vous a été envoyé directement, vous recevrez un crédit-cadeau d'une valeur égale à celle de votre retour. Une fois que nous aurons reçu l'article retourné, un chèque-cadeau vous sera envoyé par mail et crédité directement sur votre compte, si vous en avez un.

    Si l'article n'a pas été identifié comme un cadeau lors de l'achat, ou si le donateur du cadeau a préféré recevoir d'abord l'article pour vous l'offrir plus tard, nous enverrons un remboursement au donateur du cadeau et il saura que vous avez retourné l'article.", place: 6, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
    %{name: "- EXPÉDITION -", page_id: 3, content: "Pour retourner un produit, vous devez l'envoyer par la poste à l'adresse :
    Kira, 146 route de Corbeil, Bât.5 - Apt 3007, 91180, St-Germain-lès-Arpajon, France.

    Il vous incombera de payer vos propres frais d'expédition pour retourner votre article. Les coûts d'expédition ne sont pas remboursables. Si vous recevez un remboursement, il ne comprendra pas vos frais de retour.

    En fonction de l'endroit où vous vivez, le délai nécessaire pour recevoir votre produit échangé peut varier.

    Si vous expédiez un article d'une valeur supérieure à 75 €, vous devriez envisager d'utiliser un service de livraison qui vous permet de suivre l'envoi ou de souscrire à une assurance de livraison. Nous ne garantissons pas que nous recevrons l'article que vous nous retournez.

    ", place: 7, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
    %{name: "EXPÉDITION ET LIVRAISON DES COMMANDES", page_id: 4, content: "Une fois votre commande passée, un mail de confirmation récapitulatif de votre commande vous sera envoyé.
    Toute commande est traitée dans un délai de 1 à 5 jours ouvrés. Elle est expédiée en lettre suivie sans assurance par la Poste afin de suivre la traçabilité du colis.
    La marque Kira ne peut être tenue responsable des retards, dégradations et pertes du transporteur. Le remboursement n’est donc pas possible.
    Le colis est livré à l’adresse de livraison renseignée lors de la commande.", place: 1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
    %{name: "", page_id: 5, content: "Tous les bijoux de la marque Kira sont faits en argent 925, vermeil (argent 925 plaqué or 3 microns 18k) ou en laiton plaqué or 3 microns 18k. Ces matières fines s’oxydent avec le temps, au contact de l’air, de la peau, de l’humidité. Pour nettoyer vos bijoux et leur faire retrouver leur éclat et leur couleur d’origine, il vous suffit de les frotter doucement avec une brosse à dent à poils souple et du dentifrice blanc. Après rinçage, vos bijoux seront comme neufs ! D’autre part, n’hésitez pas à porter vos bijoux Kira sous la douche. L’eau claire et le savon leur évitera de s’oxyder trop rapidement.
    Tous les bijoux sont sans nickel, sans plomb et sans cadmium.", place: 1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
    %{name: "", page_id: 6, content: "Merci de lire avec attention les différentes modalités d'utilisation du présent site avant d'y parcourir ses pages. En vous connectant sur ce site, vous acceptez sans réserves les présentes modalités. Aussi, conformément à l'article n°6 de la Loi n°2004-575 du 21 Juin 2004 pour la confiance dans l'économie numérique, les responsables du présent site internet www.kira-bijoux.com sont :", place: 1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
    %{name: "Editeur du Site :", page_id: 6, content: "Kira (micro-entreprise)
    Cyrielle Gallou (auto-entrepreneur)
    Numéro SIREN : 802 858 910
    Siège : 146 route de Corbeil 91180 St-Germain-lès-Arpajon
    Téléphone : 0621492911
    Email : contact@kira-bijoux.com
    Site Web : www.kira-bijoux.com
    Le directeur de la publication du site web kira-bijoux.com est Cyrielle Gallou.", place: 2, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
    %{name: "Hébergement :", page_id: 6, content: "Hébergeur : Amazon Web Services LLC
    P.O. Box 81226 - Seattle, WA 98108-1226
    Site Web : https://aws.amazon.com/", place: 3, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
    %{name: "Développement :", page_id: 6, content: "Jordan Bruneel - Full Stack Developer JavaScript/PHP
    Canelle Delbreil - Full Stack Developer Phoenix/Elixir
    Hugo Fief - Full Stack Developer Angular/.Net
    Cyrielle Gallou - Full Stack Developer Angular/Java", place: 4, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
    %{name: "Conditions d'utilisation", page_id: 6, content: "Ce site (www.kira-bijoux.com) est développé en différents langages web (HTML5, SCSS, TypeScript, Elixir, etc). Pour un meilleur confort d'utilisation et un graphisme plus agréable, nous vous recommandons de recourir à des navigateurs modernes comme Internet explorer, Safari, Firefox, Google Chrome, etc.

    Ce site est un site e-commerce ayant pour vocation la vente de bijoux artisanaux en ligne.

    L'éditeur du site met en œuvre tous les moyens dont il dispose pour assurer une information fiable et une mise à jour régulière de son site internet. Toutefois, des erreurs ou omissions peuvent survenir. L'internaute devra donc s'assurer de l'exactitude des informations auprès de lui, et signaler toutes modifications du site qu'il jugerait utile. L'éditeur n'est en aucun cas responsable de l'utilisation faite de ces informations, et de tout préjudice direct ou indirect pouvant en découler.", place: 5, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
    %{name: "Cookies", page_id: 6, content: "Le site www.kira-bijoux.com peut être amené à vous demander l'acceptation de cookies pour des besoins de statistiques et d'affichage. Un cookies est une information déposée sur votre disque dur par le serveur du site que vous visitez. Il contient plusieurs données qui sont stockées sur votre ordinateur dans un simple fichier texte auquel un serveur accède pour lire et enregistrer des informations.", place: 6, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
    %{name: "Liens hypertextes", page_id: 6, content: "Le site internet www.kira-bijoux.com peut proposer des liens vers d'autres sites internet ou d'autres ressources disponibles sur Internet. L'éditeur ne dispose d'aucun moyen pour contrôler les sites en connexion avec son site internet. L'éditeur ne répond pas de la disponibilité de tels sites et sources externes, ni ne la garantit. Il ne peut être tenu pour responsable de tout dommage, de quelque nature que ce soit, résultant du contenu de ces sites ou sources externes, et notamment des informations, produits ou services qu'ils proposent, ou de tout usage qui peut être fait de ces éléments. Les risques liés à cette utilisation incombent pleinement à l'internaute, qui doit se conformer à leurs conditions d'utilisation.

    Les utilisateurs et les visiteurs du site internet www.kira-bijoux.com ne peuvent pas mettre en place un hyperlien en direction de ce site sans l'autorisation expresse et préalable de l'éditeur.

    Dans l'hypothèse où un utilisateur ou visiteur souhaiterait mettre en place un hyperlien en direction du site internet www.kira-bijoux.com, il lui appartiendra d'adresser un email accessible sur le site afin de formuler sa demande de mise en place d'un hyperlien. L'éditeur se réserve le droit d'accepter ou de refuser un hyperlien sans avoir à en justifier sa décision.", place: 7, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
    %{name: "Limitation contractuelles sur les données :", page_id: 6, content: "Les informations contenues sur ce site sont aussi précises que possible et mises à jour régulièrement, mais peuvent toutefois contenir des inexactitudes ou des omissions. Si vous constatez une lacune, erreur ou ce qui parait être un dysfonctionnement, merci de bien vouloir le signaler par email accessible sur le site en décrivant le problème de la manière la plus précise possible (page posant problème, type d'ordinateur et de navigateur utilisé, etc).

    Tout contenu téléchargé se fait aux risques et périls de l'utilisateur et sous sa seule responsabilité. En conséquence, l'éditeur ne saurait être tenu responsable d'un quelconque dommage subi par l'ordinateur de l'utilisateur ou d'une quelconque perte de données consécutives au téléchargement. De plus, l'utilisateur du site s'engage à accéder au site en utilisant un matériel récent, ne contenant pas de virus et avec un navigateur de dernière génération mis-à-jour.

    Les liens hypertextes mis en place dans le cadre du présent site internet en direction d'autres ressources présentes sur le réseau Internet ne sauraient engager la responsabilité de l'éditeur.", place: 8, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
    %{name: "Propriété intellectuelle :", page_id: 6, content: "Tout le contenu du présent site www.kira-bijoux.com, incluant, de façon non limitative, les graphismes, images, textes, vidéos, animations, sons, logos, gifs et icônes ainsi que leur mise en forme sont la propriété exclusive de l'éditeur à l'exception des marques, logos ou contenus appartenant à d'autres sociétés partenaires ou auteurs.

    Toute reproduction, distribution, modification, adaptation, retransmission ou publication, même partielle, de ces différents éléments est strictement interdite sans l'accord express par écrit de l'éditeur. Cette représentation ou reproduction, par quelque procédé que ce soit, constitue une contrefaçon sanctionnée par les articles L.335-2 et suivants du Code de la propriété intellectuelle. Le non-respect de cette interdiction constitue une contrefaçon pouvant engager la responsabilité civile et pénale du contrefacteur. En outre, les propriétaires des contenus copiés pourraient intenter une action en justice à votre encontre.", place: 9, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
    %{name: "Litiges :", page_id: 6, content: "Les présentes conditions du site www.kira-bijoux.com sont régies par les lois françaises et toutes contestations ou litiges qui pourraient naître de l'interprétation ou de l'exécution de celles-ci seront de la compétence exclusive des tribunaux dont dépend le siège social de la société. La langue de référence, pour le règlement de contentieux éventuels, est le français.", place: 10, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
    %{name: "Données personnelles :", page_id: 6, content: "De manière générale, vous n'êtes pas tenu de nous communiquer vos données personnelles lorsque vous visitez notre site Internet www.kira-bijoux.com.

    Cependant, ce principe comporte certaines exceptions. En effet, pour certains services proposés par notre site, vous pouvez être amenés à nous communiquer certaines données telles que : votre nom, votre prénom, votre adresse postale, votre adresse électronique, et votre numéro de téléphone. Tel est le cas lorsque vous vous inscrivez, ou lorsque vous passez une commande de produits proposés sur le site www.kira-bijoux.com. Le site www.kira-bijoux.com ne conserve en aucun cas vos données bancaires.

    Dans tous les cas, vous pouvez refuser de fournir vos données personnelles. Dans ce cas, vous ne pourrez pas utiliser certains services du site, notamment celui de s'inscrire ou encore celui vous permettant d'acheter des produits proposés par le site www.kira-bijoux.com.

    Enfin, nous pouvons collecter de manière automatique certaines informations vous concernant lors d'une simple navigation sur notre site Internet, notamment : des informations concernant l'utilisation de notre site, comme les zones que vous visitez et les services auxquels vous accédez, votre adresse IP, le type de votre navigateur, vos temps d'accès.

    De telles informations sont utilisées exclusivement à des fins de statistiques internes, de manière à améliorer la qualité des services qui vous sont proposés. Les bases de données sont protégées par les dispositions de la loi du 1er juillet 1998 transposant la directive 96/9 du 11 mars 1996 relative à la protection juridique des bases de données.", place: 11, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)}
  ]
  )
  end
end
