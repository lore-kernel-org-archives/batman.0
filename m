MIME-Version: 1.0
In-Reply-To: <200906130408.45362.lindner_marek@yahoo.de>
References: <5161afcd0906111040v1e2831ccv79c8ab6a5ca6cb58@mail.gmail.com>
	<5161afcd0906120821w5698c18ag7b993869377e3d61@mail.gmail.com>
	<5161afcd0906121019w4ec402a2ged0c622013515ea6@mail.gmail.com>
	<200906130408.45362.lindner_marek@yahoo.de>
Date: Fri, 12 Jun 2009 14:27:44 -0600
Message-ID: <5161afcd0906121327m603d4c4ftc02458f30d39ff9c@mail.gmail.com>
From: Jacob Marble <jacobmarble@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] batman advanced in openwrt
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

On Fri, Jun 12, 2009 at 2:08 PM, Marek Lindner<lindner_marek@yahoo.de> wrot=
e:
> On Saturday 13 June 2009 01:19:51 Jacob Marble wrote:
>> Some of my nodes cannot see each other... =C2=A0For example, node 1 can
>> battool ping node 2, but node 2 cannot battool ping node 1.
>
> That would be pretty strange as batman always has to make sure that the
> connection goes in both directions. Can you post the originators output p=
lus
> the batping result ?

I will when it happens again.

>> "cat ath0 > /proc/net/batman-adv/interfaces"
>> produces:
>> "Can't activate module: the primary interface is not active"
>
> This message indicates that this nodes already has one interface which is=
 not
> activate. Could you post "cat /proc/net/batman-adv/interfaces" after you =
get
> this result ?

"echo 'ath0' > interfaces"
"cat interfaces"
ath0

[     97532] Adding interface: ath0
[     97532] Can't activate module: the primary interface is not active
[     97534] Adding route towards: 00:15:6d:a7:6a:14 (via 00:15:6d:a7:6a:14=
)
[     97534] Creating new global hna entry: 00:ff:cf:5c:68:e0 (via
00:15:6d:a7:6a:14)
[     97535] Adding route towards: 00:15:6d:a7:6a:9c (via 00:15:6d:a7:6a:9c=
)
[     97535] Creating new global hna entry: 00:ff:a2:47:d9:c3 (via
00:15:6d:a7:6a:9c)
[     97539] Changing route towards: 00:15:6d:a7:6a:9c (now via
00:15:6d:a7:6a:14 - was via 00:15:6d:a7:6a:9c)

>> The node that can ping out, but not be pinged gave the following before =
it
>> died:
>>
>> "Could not read from deactivated interface <NULL>!"
>
> Can you explain the exact steps to reproduce this behaviour ?

I will when it happens again.

Jake
