Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 21 Jan 2010 18:34:10 +0800
References: <973ad7df1001210147o5e2290c4y85434a798d5c1c7b@mail.gmail.com>
In-Reply-To: <973ad7df1001210147o5e2290c4y85434a798d5c1c7b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201001211834.11220.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Batman questions
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


Hi,

> I do not understand what the transmission quality in OGMs is for. From my
> reading of the RFC draft, route selection is done based on the number of
> OGMs received for a specific destination within a sliding window of
>  sequence numbers. I did catch a comment in the source code about 
>  transmission quality it being used for bidirectional link detection, but
>  there I couldn't find a mention of transmission quality in the draft RFC.

the RFC describes BATMAN III which is outdated since quite a while. In the 
field you will find BATMAN IV that eliminates numerous problems. 

A comprehensive documentation can be found here:
http://gitorious.org/batman-adv-doc

Meanwhile we are working on mark V:
http://www.open-mesh.org/wiki/2009-12-18-batman-v-outlook


>  I don't know what is being used for the extra 8 bytes of batman data. I
>  guess the originator and receiver portions of the packet are now 6 byte MAC
>  addresses rather than 4 byte IP addresses. However, this does not account
>  for extra 8 bytes used for BATMAN-ADV.

Please check the dissectors Sven mentionned or use batctl or read the IV-PDF 
to get an overview about the protocol changes.


> In the future, it seems like BATMAN-ADV will get the majority of the
> developer attention. Other than not having to asign IP addresses, which
>  does seem pretty cool, I am finding it hard to see 'major' advantages of
>  one versus another. 

Just to name a few:
* protocol independence (IPv4, IPv6, IPX, whatever)
* you can run DHCP over your mesh to autoconfig non-mesh clients
* roaming for the non-mesh clients
* full control over the mesh traffic which enables you to do: bonding / forward 
error correction / etc
* multicast support


>  This advantage also seems to be slightly offset because it now becomes
>  harder to get gateway information. Is this right?

The gateway problem has been resolved in the trunk (check the mail archives if 
you are interested in details).


> Does working at the data link layer make it easier to extract, neighbour
> SNR's or bit rates from the wireless driver? What about power control? I'm
> just throwing ideas around here (I haven't thought this through) but could
> you have a power save mode whereby if the device is battery powered and has
> > 8 neighbours, then slowly reduce the transmission power until neighbours
> is < 4 or mains powered batman neighbours is <2.

Extracting the bitrates from the drivers is completely unrelated to the layer 
the mesh runs on. Whether it will bring advantages to have those information 
remains yet to be seen.

You don't want to run any kind of mesh on a battery driven device. Even if 
your mesh protocol saved all the power it could, the wifi power control 
protocols won't work on adhoc mode. Therefore your device will be drained in 
no time. Furthermore, you don't need it - with batman-adv you bridge the wifi 
client into the mesh and get the benefit of the mesh (roaming) plus power 
saving from the managed network.

Regards,
Marek
