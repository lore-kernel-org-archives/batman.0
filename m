Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Subject: Re:
References: <CADSehqPoEQGqdURG0g8OO85Dvb5dL0eExwG+-9uum8=wz9VXsg@mail.gmail.com>
From: fboehm@aon.at
Message-ID: <08019330-dc15-cf5f-eaf2-4ee3cfac8aa5@aon.at>
Date: Thu, 14 May 2020 12:29:27 +0200
MIME-Version: 1.0
In-Reply-To: <CADSehqPoEQGqdURG0g8OO85Dvb5dL0eExwG+-9uum8=wz9VXsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

Maksim, for clarification:

ATWILC3000 is a Wifi-Module for low-end embedded systems. This module 
consists of a Wifi-Chip + a small processor. The processor does stuff 
like authentication/registration with the Wifi network, WPA-Encryption 
and this kind of things. A typical use-case would be to add a Wifi 
interface to some sort of IoT device or some sort of computer peripheral 
device (like a Wifi-enabled printer or a smart-speaker).

Looking at the driver code it might not be impossible but it's just very 
unlikely that you will be happy to use it in combination with Batman. 
You would first of all need to connect the module to a much more 
powerful processor that runs Linux and Batman. But assuming you anyway 
need such a powerful processor for your application then you have a good 
chance that you can use a real Wifi-Adapter (with USB or PICe interface) 
instead of such a Wifi-Module.

Regards,
Franz


Am 14.05.20 um 10:17 schrieb Maksim Iushchenko:
> Hello,
> I am creating a Wi-Fi ad-hoc network based on batman-adv. I read that
> batman-adv is able to work with any types of interfaces, but I still
> have a question related to ad-hoc networking. Will Wi-Fi ad-hoc
> network (based on batman-adv) work if Wi-Fi chip does not support
> 802.11s standard?
> Unfortunately, there is no mention of ad-hoc mode support in
> documentation of many Wi-Fi chips.
>
> How to check if a Wi-Fi chip is suited to be used to create a Wi-Fi
> ad-hoc network based on batman-adv?
>
> For example, is ATWILC3000-MR110CA an appropriate chip to build a
> Wi-Fi ad-hoc network based on batman-adv? Or maybe you could suggest
> any another Wi-Fi chips?
>
> Thanks in advance

