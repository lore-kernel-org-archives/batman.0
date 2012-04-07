Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat,  7 Apr 2012 23:06:06 +0200
Message-Id: <1333832769-28493-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 0/3] clean up patches
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

** this patches are for batman-ad/next ***

After my first pull request, David S. Miller hardly suggested me to fix some
problems that I am going to summarise here. Please respect such suggestions in
your next patches:

1) Multi-line comments must end with */ on a new line:

/* ..
 * ..
 */

2) if we use #ifdef in our headers to redefine some functions depending on the
fact that we are compiling a component or not, we must use static inline
functions doing nothing with the correct parameters instead of simple
"foo(...)". In this way we can allow the compiler to check for the types and the
number of arguments:

Instead of:

#define bla_init(...) (1)

we must do:

static inline bla_init(struct bat_priv *bat_priv)
{ 
	return 1;
}


Other than David's complaining I also get a suggestion from Bernd Petrovitsch
about the type of stp_addr (it should be "static const uint8_t []" instead of
"uint8_t []" only). I applied such change in patch 2/3.

Cheers,


