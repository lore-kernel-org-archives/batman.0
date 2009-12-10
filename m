Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 10 Dec 2009 12:00:33 +0800
References: <771195.22552.qm@web111610.mail.gq1.yahoo.com>
	<15EDF7F5-2A4A-4A77-87F4-193AFAA1B7CD@lo-res.org>
In-Reply-To: <15EDF7F5-2A4A-4A77-87F4-193AFAA1B7CD@lo-res.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200912101200.33322.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] point me to some OSI layer diagrams if possible ?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net
Cc: olsr list users mailing <olsr-users@lists.olsr.org>

On Thursday 10 December 2009 07:40:53 L. Aaron Kaplan wrote:
> | link, 802.11s, B.A.T.M.A.N  layer 2 version, OLPC's  802.11s|  2    the
> | HWMP and all the 80.211s stuff resides here. 802.11a/b/g/n resides here.
> | Madwifi, ath5k and ath9k reside here. 

Sorry, but that is not (entirely) correct. It is no problem calling batman-adv 
a layer 2 protocol for the sake of simplicity (it deals with MAC addresses 
instead of IP addresses, etc ..). But if you mention batman-adv and 
802.11s/ath5k/etc in the same sentence you have to be more precise as they do 
not operate on the same layer.

batman-adv is layer 2.5 and runs on top of all ethernet based layer 2 
protocols which means you can run it over wireless 
(managed/adhoc/mesh/whatever mode), plain ethernet cable, VPNs and so on.

However, 802.11s is "true" layer 2 and as such is limited to the medium 
(wireless) as well as to the hardware & drivers. 


Regards,
Marek
