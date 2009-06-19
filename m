Return-Path: <jacobmarble@gmail.com>
MIME-Version: 1.0
In-Reply-To: <200906191950.54769.lindner_marek@yahoo.de>
References: <5161afcd0906181142o4c85ef5dr85fa1c2f54376fc7@mail.gmail.com>
	<200906191950.54769.lindner_marek@yahoo.de>
Date: Fri, 19 Jun 2009 10:05:21 -0600
Message-ID: <5161afcd0906190905o23035e1cnc661438cdccd131d@mail.gmail.com>
From: Jacob Marble <jacobmarble@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] opkg doesn't rmmod
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Fri, Jun 19, 2009 at 5:50 AM, Marek Lindner<lindner_marek@yahoo.de> wrot=
e:
> On Friday 19 June 2009 02:42:54 Jacob Marble wrote:
>> When I "opkg remove kmod-batman-adv-kernelland", the kernel module
>> stays loaded, so when I "opkg install kmod-batman-adv-[newer version]"
>> the old module stays loaded. =C2=A0A simple rmmod gets rid of the old
>> module.
>
> I thought of that more as a feature as it allows over the mesh updates. I=
f I
> the module gets removed while running an update over the mesh you might r=
ender
> your node unusable. On the other hand you can reboot the node after the u=
pdate
> was completed to have a consistent system.
>
>

Hmm, you're right there.  Too bad there isn't a way to "opkg remove X
--preserve-loaded-modules"

>> There is a script in the openwrt SVN called postinst that inserts the
>> module after install. =C2=A0Very convenient. =C2=A0A similar script coul=
d be
>> added, called prerm, that would remove the module before removing the
>> ipk. =C2=A0There are several ways to rmmod; "rmmod -f batman-adv" might =
be
>> best for removing the package.
>>
>> When I create the file in my build_dir, make just deletes it, so I
>> leave this up to someone else (Marek?).
>
> You have to place the script into the corresponding package folder (batma=
n-adv
> in this case) to avoid deletion. For OpenWRT the package directory is the
> source (nothing will be deleted there) and build_dir is the build path.
>
> If you agree to the point mentioned above I still could add your script b=
ut
> keep it deactivated, so that other people can find it. May be someone has=
 an
> idea how to keep everyone happy. =C2=A0:-)
