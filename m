Return-Path: <tonyputi@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFevQmMJiKnWwa9miU+eFe4WsGRCTj_H6Y+L91jqhM41G0wW4g@mail.gmail.com>
References: <mailman.52.1312816695.1125.b.a.t.m.a.n@lists.open-mesh.org>
	<201108161730.03159.lindner_marek@yahoo.de>
	<CAFevQmO7KeQcjj1tpxCarUaASE=PZNiEp+VpKOxcffgFKb86cQ@mail.gmail.com>
	<201108220146.25744.lindner_marek@yahoo.de>
	<CAFevQmMJiKnWwa9miU+eFe4WsGRCTj_H6Y+L91jqhM41G0wW4g@mail.gmail.com>
From: Filippo Sallemi <tonyputi@gmail.com>
Date: Mon, 12 Sep 2011 19:43:47 +0200
Message-ID: <CAFevQmP7Qu5iMi6nHG3WJdbXFAEQej9Ro7W9aEkLxg4YhSX-wQ@mail.gmail.com>
Content-Type: multipart/mixed; boundary=20cf305638e3e05d3904acc212a6
Subject: Re: [B.A.T.M.A.N.] openwrt lib/batman-adv/config.sh
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--20cf305638e3e05d3904acc212a6
Content-Type: text/plain; charset=UTF-8

Hi all,
I've writed a hotplug.d script that readd interfaces that are present
in every bat definition of batman-adv uci file when network restart or
 an interface come up.
This script must be placed in /etc/hotplug.d/net/

P.S. for Marek you don't need to split /etc/init.d/batman-adv function
in a separate file such the previous emails.

Rgds.

Filippo

2011/8/24 Filippo Sallemi <tonyputi@gmail.com>:
> Ok. I'm just working on it
>
> 2011/8/22 Marek Lindner <lindner_marek@yahoo.de>:
>> On Wednesday, August 17, 2011 06:54:20 Filippo Sallemi wrote:
>>> No. no prblem from me
>>
>> Ok, I just comitted the new package. Let me know when you have the hotplug
>> stuff ready to be included as well.
>>
>> Regards,
>> Marek
>>
>
>
>
> --
> Filippo Sallemi
>



-- 
Filippo Sallemi

--20cf305638e3e05d3904acc212a6
Content-Type: application/octet-stream; name=99-batman-adv
Content-Disposition: attachment; filename=99-batman-adv
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gshql1u60

IyEvYmluL3NoCiMgQ29weXJpZ2h0IChDKSAyMDExIE9wZW5XcnQub3JnCgpzZXR1cF9pZmFjZSgp
ewoJbG9jYWwgbWVzaD0kMQoJbG9jYWwgZGV2aWNlPSQyCglsb2NhbCBpbnRlcmZhY2VzCgkKCWNv
bmZpZ19nZXQgaW50ZXJmYWNlcyAkbWVzaCBpbnRlcmZhY2VzCgkKCWZvciBpbnRlcmZhY2UgaW4g
JGludGVyZmFjZXM7IGRvCgkJWyAhIC1mICIvc3lzL2NsYXNzL25ldC8kaW50ZXJmYWNlL2JhdG1h
bl9hZHYvbWVzaF9pZmFjZSIgXSAmJiB7CgkJCWludGVyZmFjZT0kKHVjaSAtUCAvdmFyL3N0YXRl
IGdldCBuZXR3b3JrLiRpbnRlcmZhY2UuaWZuYW1lIDI+Ji0pCgkJCVsgISAtZiAiL3N5cy9jbGFz
cy9uZXQvJGludGVyZmFjZS9iYXRtYW5fYWR2L21lc2hfaWZhY2UiIF0gJiYgY29udGludWUKCQl9
CgkJCgkJWyAiJGRldmljZSIgPT0gICIkaW50ZXJmYWNlIiBdICYmIHsKCQkJZWNobyAkbWVzaCA+
IC9zeXMvY2xhc3MvbmV0LyRpbnRlcmZhY2UvYmF0bWFuX2Fkdi9tZXNoX2lmYWNlCgkJfQoJZG9u
ZQp9CgpjYXNlICIkQUNUSU9OIiBpbgogICAgYWRkKQoJCWNvbmZpZ19jbGVhcgoJCWNvbmZpZ19s
b2FkIGJhdG1hbi1hZHYKCQljb25maWdfZm9yZWFjaCBzZXR1cF9pZmFjZSBtZXNoICRJTlRFUkZB
Q0UKCTs7CmVzYWM=
--20cf305638e3e05d3904acc212a6--
