Return-Path: <yajun.deng@linux.dev>
MIME-Version: 1.0
Date: Thu, 28 Oct 2021 07:49:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: yajun.deng@linux.dev
Message-ID: <6da1057ad867699815cef87cb2a79057@linux.dev>
Subject: Re: [PATCH net-next] batman-adv: Fix the wrong definition
In-Reply-To: <da6fa493-0911-ca3f-16c0-380bc35d8317@unstable.cc>
References: <da6fa493-0911-ca3f-16c0-380bc35d8317@unstable.cc>
 <20211028072306.1351-1-yajun.deng@linux.dev>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>, mareklindner@neomailbox.ch, sw@simonwunderlich.de, sven@narfation.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

October 28, 2021 3:35 PM, "Antonio Quartulli" <a@unstable.cc> =E5=86=99=
=E5=88=B0:=0A=0A> Hi,=0A> =0A> On 28/10/2021 09:23, Yajun Deng wrote:=0A>=
 =0A>> There are three variables that are required at most,=0A>> no need =
to define four variables.=0A>> =0A>> Fixes: 0fa4c30d710d ("batman-adv: Ma=
ke sysfs support optional")=0A>> Signed-off-by: Yajun Deng <yajun.deng@li=
nux.dev>=0A> =0A> NAK.=0A> =0A> kobject_uevent_env() does not know how ma=
ny items are stored in the=0A> array and thus requires it to be NULL term=
inated.=0A> =0A> Please check the following for reference:=0A> =0A> https=
://elixir.bootlin.com/linux/v5.15-rc6/source/lib/kobject_uevent.c#L548=0A=
> =0AOh, I didn't notice there.=0A> OTOH I guess we could still use '{}' =
for the initialization.=0A> =0A> Regards,=0A> =0A> --=0A> Antonio Quartul=
li
