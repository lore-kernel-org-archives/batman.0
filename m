Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 2 Apr 2012 00:35:55 +0300
References: <CAA_JP8UrWSzLYoUEhrzbT1fjeedp28B0dr7dMB_TizLkr+4RNg@mail.gmail.com>
	<CAA_JP8VjODMM-znsQLM-GyxWjXDJ70Y5yjh_EhgokEY3O+iKAg@mail.gmail.com>
	<CAHD-aqJEvYHpiMBZE5Sp8QzcHJfLVuwzK9Wh4Bf0rN6BA6t0OQ@mail.gmail.com>
In-Reply-To: <CAHD-aqJEvYHpiMBZE5Sp8QzcHJfLVuwzK9Wh4Bf0rN6BA6t0OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201204020035.55940.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] any throughput mechanism or plans?
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

On Sunday, April 01, 2012 05:39:05 Guido Iribarren wrote:
> So far, with openwrt and ath9k / ath9k_htc, i've found the "tx
> bitrate" (or MCS level) a fair indicator of the link capacity.
> if it says "65.0 MBit/s MCS 7" i cannot tell exactly how much goodput
> it will have, but i can be pretty confident that it will be better
> than when it says "6.5 MBit/s MCS 1"

This info is pretty useless since the reported tx rate is the rate used to 
send the last packet. If the last packet is sent via broadcast the tx rate 
will show the broadcast tx rate.

Regards,
Marek
