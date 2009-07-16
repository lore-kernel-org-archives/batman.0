Return-Path: <edwecowley@gmail.com>
MIME-Version: 1.0
In-Reply-To: <200907160121.28937.lindner_marek@yahoo.de>
References: <dd8d36130907150659v74773aw1fd1060c43ab337b@mail.gmail.com>
	<200907160121.28937.lindner_marek@yahoo.de>
Date: Thu, 16 Jul 2009 08:57:28 +0200
Message-ID: <dd8d36130907152357u38896852v7fa5f8214568dd47@mail.gmail.com>
From: Edwe Cowley <edwecowley@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [vis] Remove duplicate routes from vis output
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

The vis server seems to work perfectly after applying your proposed
patch. Thank you.

Regards

Edwe

On Wed, Jul 15, 2009 at 7:21 PM, Marek Lindner<lindner_marek@yahoo.de> wrot=
e:
> On Wednesday 15 July 2009 21:59:32 Edwe Cowley wrote:
>> Revision 1271 introduced a bug on the call to hash->compare() that
>> caused duplicate routes to appear in the output. =A0Inverted the
>> conditional and now it works.
>
> Thanks for informing us about this bug and proposing a solution. This is =
a bit
> tricky since batman and the vis server share the same hash implementation
> code. If we apply your patch we will move the bugs to batman. As you corr=
ectly
> pointed out the bug was introduced with 1271 because the vis hash->compar=
e()
> callback function was not adapted. Please consider my following patch and=
 let
> me know if it works for you.
>
> Regards,
> Marek
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
