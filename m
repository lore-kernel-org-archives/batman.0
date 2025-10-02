Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DBDCAC5B0
	for <batman@archiver.kernel.org>; Thu,  2 Oct 2025 16:40:05 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6B949852CD
	for <batman@archiver.kernel.org>; Thu, 02 Oct 2025 18:40:04 +0200 (CEST)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1759423204;
 b=xRPZdRkOAIyqG1I5hRe0bsv7ouDuiMIl9AEkqPhg9VkQgl73sfSBR7QZRwnTsL1sd+tOi
 D1KQ95OXXtT2/VupGM5MnudqP3Q3rLh8ij/GqTll/LvqPPZ4s8wzuKdyBzTkll3WSbTatFz
 heoBJMCe1lmH7YKMxsIgwe5dqISwoSQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1759423204; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=vdRBjGQg8UkIC/rbk9+KXS6eY8Y0mIneUp6Qntgl0oI=;
 b=l3Lw6SjDrtAt3J0PTvLkm3NpzoQYT47gEqpbURG2yqGqxnMEZ4eIijisAnPmlANYZ7xZO
 Vjqz1JyPWfKprLvv7QTNb3mRSOsbFDTah6CaotbFu7hSZYJxQC7bTh6Cpodrb9tb624iIic
 3BpLtMVIz+mhAuxI3kcfCDMEpuJ+iPU=
ARC-Authentication-Results: i=1; open-mesh.org;
 dkim=fail;
 arc=none;
 dmarc=fail header.from=gmail.com policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail;
 arc=none (Message is not ARC signed);
 dmarc=fail (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4781D848FD
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 02 Oct 2025 18:39:28 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: =?utf-8?b?2LTZh9in2K/YqSDYp9mE2KPYqNmI2Kkg2YHZiiDYp9mE2YXYutix2Kg=?=
From: jibl3azzmenusa@gmail.com
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Thu, 02 Oct 2025 16:39:28 -0000
Message-ID: <175942316829.1531.10187674206231752123@diktynna.open-mesh.org>
User-Agent: HyperKitty on https://lists.open-mesh.org/
Message-ID-Hash: RNOGNU2JNZM3VQOTWTTZYYA2DJIJW7QT
X-Message-ID-Hash: RNOGNU2JNZM3VQOTWTTZYYA2DJIJW7QT
X-MailFrom: jibl3azzmenusa@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RNOGNU2JNZM3VQOTWTTZYYA2DJIJW7QT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

كل ما تحتاج معرفته حول شهادة الأبوة بالمغرب

يمكنك تحميل الطلب من خلال الرابط المباشر
https://www.targir.com/2025/04/blog-post_14.html

معلومات شاملة لاستخراج شهادة الأبوة والإجراءات القانونية المرتبطة بها

ما هي شهادة الأبوة في المغرب؟

شهادة الأبوة وثيقة قانونية تصدر بناءً على حكم قضائي، وتُثبت العلاقة البنوية بين الطفل ووالده البيولوجي، في حال عدم وجود عقد زواج رسمي أو تسجيل سابق. تُعَد هذه الشهادة جزءًا من الإجراءات القضائية التي تدخل ضمن قضايا الحالة المدنية.

الحالات التي تستوجب استخراج شهادة الأبوة
1. الأطفال غير المسجلين في الحالة المدنية
عندما يولد طفل خارج إطار الزواج أو لم يُسجَّل بصفة قانونية في دفتر الحالة المدنية، يحتاج الأب إلى رفع دعوى للحصول على شهادة الأبوة.

2. إثبات النسب في غياب عقد زواج
في حالات عدم توفر وثيقة الزواج بين الأبوين، يُلجأ إلى المحكمة لتقديم التصريح بالأبوة.

إجراءات الحصول على شهادة الأبوة
أولا: رفع دعوى أمام المحكمة
يتوجب على الأب أو ولي أمر الطفل تقديم طلب إلى المحكمة الابتدائية التي يقع فيها مقر سكن الطفل أو الأب، وذلك من أجل إصدار حكم قضائي بإثبات الأبوة.

ثانياً: الوثائق المطلوبة
نسخة من بطاقة التعريف الوطنية
عقد الازدياد الخاص بالطفل (إن وُجد)
شهادة طبية للولادة
شهادة السكنى
وثائق أو إثباتات تدعم علاقة الأب بالطفل
نموذج شهادة الأبوة pdf
تتيح بعض المواقع الإلكترونية تحميل نموذج شهادة الأبوة PDF قابل للطباعة، غير أن إصدارها الرسمي لا يتم إلا بعد حكم قضائي، ويتم توجيهها لمصلحة الحالة المدنية لتسجيل الطفل.

الأسئلة الشائعة حول شهادة الأبوة
هل يمكن تقديم طلب شهادة الأبوة إلكترونياً؟
لا، المسطرة تظل قضائية وتتطلب الحضور أمام المحكمة.

ما هي مدة الحصول على شهادة الأبوة؟
قد تختلف المدة حسب عدد الجلسات، ولكن عادة ما تستغرق بين شهر إلى ثلاثة أشهر، حسب تعقيد الملف.

صلة بين شهادة الأبوة وبعض التصاريح القانونية الأخرى
تم الربط ضمن هذا الدليل بين شهادة الأبوة وبعض المفاهيم القانونية الأخرى التي يبحث عنها الكثير، مثل:

1. التصريح الأمني وتصريح السفر
غالباً ما يُطلب في بعض الحالات القانونية توفير تصريح أمني عند استخراج أوراق ثبوتية، كما هو الحال في:

الأوراق المطلوبة لاستخراج تصريح السفر من منطقة التجنيد
تصريح أمني مستعجل
التصريح الأمني الإلكتروني
2. استبدال التصريح برخصة قيادة
في حالات مثل شروط إصدار رخصة قيادة بعد التصريح أو تجديد التصريح إلى رخصة، من المهم التأكد من إثبات الهوية القانونية، وهو ما يجعل شهادة الأبوة ضرورية في بعض الحالات القانونية الخاصة.

شهادة الأبوة
الغاية من هذه الوثيقة هي إثبات علاقة الأبوة بالابن سواء كان راشدا أم قاصرا وغالبا ما تطلب في بعض المساطر الإدارية.

صاحب الطلب
المغربي المقيم بالخارج

الوثائق المطلوبة
بالنسبة للراشد :

·       بطاقة التسجيل ؛

·       الدفتر العائلي

بالنسبة للقاصر :

·       بطاقة تسجيل الأب ؛

·       الدفتر العائلي .

المصلحة المكلفة باستلام الوثائق المطلوبة
المصالح القنصلية التابعة لمحل إقامة صاحب الطلب

المصلحة المكلفة بتقديم الخدمة
المصالح القنصلية التابعة لمحل إقامة صاحب الطلب

في حالة تعذر الحصول على الخدمة
مؤسسة الوسيط

لأجل الاتصال
وزارة الشؤون الخارجية والتعاون

مصدر المعلومات (الإدارة المعنية)
وزارة الشؤون الخارجية والتعاون_أرشيف

يمكنك تحميل الطلب من خلال الرابط المباشر

نموذج شهادة الأبوة بالمغرب
محكمة الأسرة بـ: [اسم المدينة]
رقم الملف: [يُترك للمحكمة]
رقم القضية: [يُترك للمحكمة]

بيان تصريح بالأبوة
أنا الموقع أسفله:

الاسم الكامل: [الاسم الكامل للأب]

رقم بطاقة التعريف الوطنية: [رقم CIN]

تاريخ ومكان الازدياد: [تاريخ ومكان ولادة الأب]

العنوان الكامل: [عنوان الإقامة]

المهنة: [المهنة الحالية]

أُصرّح بموجب هذا، وبكامل قواي العقلية والقانونية، بما يلي:

أن الطفل (ة) المسمى (ة): [اسم الطفل/ة]
المولود (ة) بتاريخ: [تاريخ الولادة]
بـ: [مكان الولادة]

هو(هي) ابني/ابنتي البيولوجي(ة)، وقد وُلد(ت) نتيجة علاقة أبوية قائمة بيني وبين السيدة:
[اسم الأم]، المولودة بتاريخ: [تاريخ ميلاد الأم]، والحاملة لرقم بطاقة التعريف الوطنية: [رقم CIN الأم].

وأتحمل كامل المسؤولية القانونية والأبوية تجاه هذا الطفل/ة، وأطلب من المحكمة الموقرة إصدار حكم قضائي يثبت نسب الطفل لي، وتمكينه من التسجيل في الحالة المدنية.

الإمضاء
الإسم الكامل: _____________________
التوقيع: ___________________________
التاريخ: ____ / ____ / ________

ملاحظات :
يُرفق هذا النموذج بالوثائق الداعمة كـ: نسخة البطاقة الوطنية، شهادة السكنى، شهادة الولادة، وغيرها.
يُودَع لدى كتابة ضبط المحكمة الابتدائية (قسم قضاء الأسرة) التي يقع ضمن اختصاصها محل ولادة الطفل أو محل سكن الأب.
