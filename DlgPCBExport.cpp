/*
	TinyCAD program for schematic capture
	Copyright 1994/1995/2002-2005 Matt Pyne.

	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU Lesser General Public
	License as published by the Free Software Foundation; either
	version 2.1 of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
	Lesser General Public License for more details.

	You should have received a copy of the GNU Lesser General Public
	License along with this library; if not, write to the Free Software
	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

// DlgPCBExport.cpp : implementation file

#include "stdafx.h"
#include "tinycad.h"
#include "DlgPCBExport.h"
#include "TinyCadRegistry.h"


/////////////////////////////////////////////////////////////////////////////
// CDlgPCBExport dialog


CDlgPCBExport::CDlgPCBExport(CWnd* pParent /*=NULL*/)
	: CDialog(CDlgPCBExport::IDD, pParent)
{
	//{{AFX_DATA_INIT(CDlgPCBExport)
	m_Filename = _T("");
	m_Prefix = FALSE;
	//}}AFX_DATA_INIT

	m_type = CTinyCadRegistry::GetInt( "Netlist", 0 );
	m_Prefix = CTinyCadRegistry::GetBool( "PrefixNetlist", 0 );
}


void CDlgPCBExport::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CDlgPCBExport)
	DDX_Control(pDX, IDC_FILE_TYPE, m_Filetype);
	DDX_Text(pDX, IDC_FILE_NAME, m_Filename);
	DDX_Check(pDX, IDC_PREFIX, m_Prefix);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CDlgPCBExport, CDialog)
	//{{AFX_MSG_MAP(CDlgPCBExport)
	ON_BN_CLICKED(IDC_BROWSE, OnBrowse)
	ON_CBN_SELCHANGE(IDC_FILE_TYPE, OnSelchangeFileType)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDlgPCBExport message handlers

BOOL CDlgPCBExport::OnInitDialog() 
{
	CDialog::OnInitDialog();

	m_Filetype.ResetContent();
	m_Filetype.AddString( _T("TinyCAD") );
	m_Filetype.AddString( _T("PADS-PCB") );
	m_Filetype.AddString( _T("Eagle SCR") );
	m_Filetype.AddString( _T("Protel") );

	m_Filetype.SetCurSel( m_type );

	UpdateData( FALSE );

	OnSelchangeFileType();

	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}


void CDlgPCBExport::OnBrowse() 
{
	CString ext = GetExtension();

	// Generate the filter string from the extension
	TCHAR szFilter[256];
	_stprintf(szFilter, _T("Netlist (*%s)|*%s|All files (*.*)|*.*||"),
		ext, ext );
	
	CFileDialog dlg( FALSE, _T("*")+ext, m_Filename, OFN_HIDEREADONLY,
		szFilter, AfxGetMainWnd() ); 

	if (dlg.DoModal() == IDOK)
	{
		m_Filename = dlg.GetPathName();
		UpdateData( FALSE );
	}
}


void CDlgPCBExport::OnOK() 
{
	// Get the data before exiting...
	UpdateData( TRUE );

	m_type = m_Filetype.GetCurSel();
	CTinyCadRegistry::Set( "Netlist", m_type );
	CTinyCadRegistry::Set( "PrefixNetlist", m_Prefix );
	
	CDialog::OnOK();
}

void CDlgPCBExport::OnSelchangeFileType() 
{
	CString ext = GetExtension();

	int b = m_Filename.ReverseFind( '.' );
	if (b != -1)
	{
		m_Filename = m_Filename.Left( b ) + ext;
	}

	UpdateData( FALSE );
}

CString CDlgPCBExport::GetExtension()
{
	UpdateData( TRUE );
	int sel = m_Filetype.GetCurSel();

	CString ext;
	switch (sel)
	{
	case 0:	// TinyCAD
		return ".net";
	case 1: // PADS
		return ".net";
	case 2: // Eagle
		return ".scr";
	case 3: // Protel
		return ".net";
	}

	return ".net";
}
