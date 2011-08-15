Return-Path: <gtolon@inti.gob.ar>
Message-ID: <4E494147.5020709@inti.gob.ar>
Date: Mon, 15 Aug 2011 12:54:47 -0300
From: gtolon@inti.gob.ar
MIME-Version: 1.0
References: <mailman.1.1313229601.6855.b.a.t.m.a.n@lists.open-mesh.org>
In-Reply-To: <mailman.1.1313229601.6855.b.a.t.m.a.n@lists.open-mesh.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Multiple DHCP Gateways
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

Thank you for your answers. I understood clearly how the system should=20
work, but i=B4m not using the git repository but the 2011.1.0 version.=20
I'll try with the repo to see what happens.

Best regards

Gabriel




> Message: 2
> Date: Fri, 12 Aug 2011 18:02:20 +0200
> From: Antonio Quartulli<ordex@autistici.org>
> To: The list for a Better Approach To Mobile Ad-hoc Networking
> 	<b.a.t.m.a.n@lists.open-mesh.org>
> Subject: Re: [B.A.T.M.A.N.] Multiple DHCP Gateways
> Message-ID:<20110812160217.GB22361@ritirata.org.org>
> Content-Type: text/plain; charset=3Dutf-8
>
> Hello and thank you for sharing your gw experience with us,
>
> On Wed, Aug 10, 2011 at 02:52:06PM -0300, gtolon@inti.gob.ar wrote:
>> Hi
> [CUT]
>> However, when the original gateway becomes
>> worse than the alternative, and the client chooses the new one as
>> preferred (observed with batctl gwl) i noticed that the subsequent
>> request DHCP messages are sent to the original server, even if it
>> doesn?t have the best link.
>>
>> I guess that?s because these subsequent DHCP requests are made as
>> Unicast to the original server and so Batman doesn?t redirect them,
>
> Unicast renewal requests are "dropped" only if the TQ towards the destina=
tion is
> smaller than the "current_GW_TQ - GW_THRESHOLD" (GW_THRESHOLD =3D 50).
> To clarify:
>
>
> In your topology you have three nodes: A, B and C. A and C are GWs. A is =
the
> current best GW for B and B got an IP from the DHCP server running on A. =
Then
> the link A<-->  B becomes worse than B<-->  C. At this point Batman-adv w=
ill
> drop a DHCP unicast renewal request directed to A
>
> if and only if TQ(C) - TQ(A)>  50
>
> Is this condition verified in your topology when your are observing the r=
enewal
> DHCP packets?
>
> I hope I've been clear. :-)
>
>> but
>> i wonder how this behavior affects the network balance, because the
>> computers would get tied always to the original DHCP and IP default
>> gateway even if they moved, right?
>
> As above. Clients will keep the same GW as long as the link is still "usa=
ble"
> (difference on TQs greater than 50)
>
>>
>> Thank you very much
>
> Thank you too,
> Antonio
>
>
> ------------------------------
>
> Message: 3
> Date: Fri, 12 Aug 2011 19:22:28 +0200
> From: Marek Lindner<lindner_marek@yahoo.de>
> To: "The list for a Better Approach To Mobile Ad-hoc Networking"
> 	<b.a.t.m.a.n@lists.open-mesh.org>
> Subject: Re: [B.A.T.M.A.N.] Multiple DHCP Gateways
> Message-ID:<201108121922.28786.lindner_marek@yahoo.de>
> Content-Type: Text/Plain;  charset=3D"utf-8"
>
> On Friday, August 12, 2011 18:02:20 Antonio Quartulli wrote:
>> In your topology you have three nodes: A, B and C. A and C are GWs. A is
>> the current best GW for B and B got an IP from the DHCP server running on
>> A. Then the link A<-->  B becomes worse than B<-->  C. At this point
>> Batman-adv will drop a DHCP unicast renewal request directed to A
>>
>> if and only if TQ(C) - TQ(A)>  50
>
> Be aware that only happens if you use the git repository. The "DHCP reque=
st
> drop" feature was not released yet.
>
> What version are you using ?
>
> Cheers,
> Marek
>
>
> ------------------------------
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.org
> https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n
>
>
> End of B.A.T.M.A.N Digest, Vol 56, Issue 15
> *******************************************
>
