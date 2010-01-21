Return-Path: <dave.murray.murdoch@gmail.com>
MIME-Version: 1.0
Date: Thu, 21 Jan 2010 17:47:50 +0800
Message-ID: <973ad7df1001210147o5e2290c4y85434a798d5c1c7b@mail.gmail.com>
From: David Murray <dave.murray.murdoch@gmail.com>
Content-Type: multipart/alternative; boundary=0016e6d64861a059ce047da998ff
Subject: [B.A.T.M.A.N.] Batman questions
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
To: b.a.t.m.a.n@lists.open-mesh.org

--0016e6d64861a059ce047da998ff
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I have a couple of questions regarding BATMAN and BATMAN-ADV

I do not understand what the transmission quality in OGMs is for. From my
reading of the RFC draft, route selection is done based on the number of
OGMs received for a specific destination within a sliding window of sequence
numbers. I did catch a comment in the source code about  transmission
quality it being used for bidirectional link detection, but there I couldn't
find a mention of transmission quality in the draft RFC.

I have been looking at BATMAN and BATMAN-ADV OGMs in Wireshark. It seems
that the BATMAN L3 OGMs have 18 bytes of BATMAN information on top of the
802.11 header (24bytes) LLC (8 bytes) IP header (20 bytes). Comparatively,
the BATMAN-ADV OGMs comprise of a 802.11 header (24bytes) LLC (8 bytes) and
26 Bytes of BATMAN data. Now because Wireshark does not recognise BATMAN-ADV
frames. I don't know what is being used for the extra 8 bytes of batman
data. I guess the originator and receiver portions of the packet are now 6
byte MAC addresses rather than 4 byte IP addresses. However, this does not
account for extra 8 bytes used for BATMAN-ADV.

In the future, it seems like BATMAN-ADV will get the majority of the
developer attention. Other than not having to asign IP addresses, which does
seem pretty cool, I am finding it hard to see 'major' advantages of one
versus another. This advantage also seems to be slightly offset because it
now becomes harder to get gateway information. Is this right?

Does working at the data link layer make it easier to extract, neighbour
SNR's or bit rates from the wireless driver? What about power control? I'm
just throwing ideas around here (I haven't thought this through) but could
you have a power save mode whereby if the device is battery powered and has
> 8 neighbours, then slowly reduce the transmission power until neighbours
is < 4 or mains powered batman neighbours is <2.

Thank you very much for your time
Dave

--0016e6d64861a059ce047da998ff
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi, <br><br>I have a couple of questions regarding BATMAN and BATMAN-ADV<br=
><br>I do not understand what the transmission quality in OGMs is for. From=
 my reading of the RFC draft, route selection is done based on the number o=
f OGMs received for a specific destination within a sliding window of seque=
nce numbers. I did catch a comment in the source code about=A0 transmission=
 quality it being used for bidirectional link detection, but there I couldn=
&#39;t find a mention of transmission quality in the draft RFC.<br>
<br>I have been looking at BATMAN and BATMAN-ADV OGMs in Wireshark. It seem=
s that the BATMAN L3 OGMs have 18 bytes of BATMAN information on top of the=
 802.11 header (24bytes) LLC (8 bytes) IP header (20 bytes). Comparatively,=
 the BATMAN-ADV OGMs comprise of a 802.11 header (24bytes) LLC (8 bytes) an=
d 26 Bytes of BATMAN data. Now because Wireshark does not recognise BATMAN-=
ADV frames. I don&#39;t know what is being used for the extra 8 bytes of ba=
tman data. I guess the originator and receiver portions of the packet are n=
ow 6 byte MAC addresses rather than 4 byte IP addresses. However, this does=
 not account for extra 8 bytes used for BATMAN-ADV.<br>
<br>In the future, it seems like BATMAN-ADV will get the majority of the de=
veloper attention. Other than not having to asign IP addresses, which does =
seem pretty cool, I am finding it hard to see &#39;major&#39; advantages of=
 one versus another. This advantage also seems to be slightly offset becaus=
e it now becomes harder to get gateway information. Is this right? <br>
<br>Does working at the data link layer make it easier to extract, neighbou=
r SNR&#39;s or bit rates from the wireless driver? What about power control=
? I&#39;m just throwing ideas around here (I haven&#39;t thought this throu=
gh) but could you have a power save mode whereby if the device is battery p=
owered and has &gt; 8 neighbours, then slowly reduce the transmission power=
 until neighbours is &lt; 4 or mains powered batman neighbours is &lt;2.<br=
>
<br>Thank you very much for your time<br>Dave<br>

--0016e6d64861a059ce047da998ff--
