Return-Path: <onelektra@gmx.net>
From: elektra <onelektra@gmx.net>
Date: Tue, 4 May 2010 15:05:34 +0200
References: <201005030828.08856.lindner_marek@yahoo.de>
	<201005041340.07717.onelektra@gmx.net> <4BE014CC.50904@aon.at>
In-Reply-To: <4BE014CC.50904@aon.at>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201005041505.34855.onelektra@gmx.net>
Subject: Re: [B.A.T.M.A.N.] sysfs compat
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

Hi Franz -

there are certified devices out there, running OpenWrt / open-source drivers. 
May I ask, what particular regulator issues you have in mind, that a open-
source driver can not comply with? Read: Are you sure you don't get the 
regulators blessing for your product with a open-source driver?

Besides: Do you know this song by Eric Idle, regarding the FCC?

http://www.youtube.com/watch?v=F4ajZ-5kTXk

A few memes:

Any product can be tampered with.

In many certified devices you can simply switch the reg domain. Then choose 
Japan, for example. Now you can transmit on channel 14 in the 2.4GHz range. 
Not so legal anywhere outside of Nippon. 

The old Broadcom chipset / proprietary driver can be configured to transmit at 
250mW with the proprietary closed source driver. Hence you can transmit at 
~25dbm EIRP (with the stock antennas), far beyond the ETSI regulations of 
20dBm EIRP.

Any device with a external antenna connector can be used together with a high-
gain antenna. Again you get far beyond the legal limits.

Cheers,
Elektra
