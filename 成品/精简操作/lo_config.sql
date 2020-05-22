
insert into InputCategories (CategoryId, Name, Visible, SortIndex) values
('CatLessOperations', 'LOC_OPTIONS_HOTKEYS_LO_NAME', '1', '10');

insert into InputActions(ActionId, Name, Description, CategoryId, ContextId) values
('AutoFortify', 'LOC_OPTION_AUTO_FORTIFY_NAME', 'LOC_OPTION_AUTO_FORTIFY_DESCRIPTION', 'CatLessOperations', 'World');
